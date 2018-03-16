/* CS 543: Assignment 2
 * Author: Gregory Matthews
 * Last Modified: 1/31/18
 */
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<string.h>
#include<sys/wait.h>
#define MAX_LINE 80 /*Maximum length commands */
char history[10][MAX_LINE];
char hist_buf[MAX_LINE];
int hist_idx = 0; //history indexing 1-10
int is_concurrent = 0; // flag for allowing concurrent processing
int len = 3; // length of argument field
// Alias key, value pairs stored in 2 corresponding arrays
char alias_key[10][MAX_LINE];
char alias_val[10][MAX_LINE];
int alias_idx = 0;

/* Function used to display history of last 10 commands */
void get_history(){
    int len;
    if (hist_idx == 0) return;;
     
    if (hist_idx > 9) len = 10;  //max of 10 element history
    else len = hist_idx;

    for (int i=0; i<len; i++) {

        printf("%d ", hist_idx-i);
        for (int j=0; j<strlen(history[len-i-1]); j++) {
            if (history[len-i-1][j] == '\n' || history[len-i-1][j] == '\0') break;
            printf("%c", history[len-i-1][j]);
        }
        printf("\n");
    }
}

/* Function Adds current commands to history array */
void update_history(char buf[]){
    if (hist_idx > 9) {
        for (int i=1; i<10; i++) {
            strcpy(history[i-1], history[i]);    
        }
        
        strcpy(history[9], buf);
    }
    else strcpy(history[hist_idx], buf);

    hist_idx++;
}

/* Token function takes a char array as input and tokenizes it into args variable */
void tokenize(char* args[], char buf[], int flag) {
    // Reading in standard input
    if (flag == 0) len = read(0, buf, MAX_LINE);
    
    // Exception handling
    if (len < 2) {
        printf("No command issued.\n");
        return;
    }
    else if (len < 0) {
        printf("Invalid Input.\n");
        return;
    }    
    
    // Special command found {!!, !N} where N = {0,1,..9}
    if (buf[0] == '!') {

        // Exception handling, no history yet
        if (hist_idx == 0) {
            printf("No commands in history.\n");
            return;
        }
        
        // !! Special command
        if (buf[1] == '!') strcpy(buf, history[hist_idx-1]);

        // !N where N = {0,1..9} special command, retrieve Nth command
        else if ((buf[1]-'0') < 10 && (buf[1]-'0') >= 0) {
            int n = buf[1] - '0';
            strcpy(buf, history[n-1]);
        }
        
        // Remove newline char
        int i=0;
        while(buf[i] != '\0') {
            if (buf[i] == '\n') buf[i] = '\0';
            i++;
        }
    }

    strcpy(hist_buf, buf); //preserve input buffer for history
    int arg_idx = 0; //used for parameter indexing of arguments
    int pivot = -1; //index of the start of each word, initially -1

    //Iterate through buffer and tokenize into args[]
    for (int i=0; i<len; i++) {
        
        //Whitespace, found end of word, add pointer to args[i]
        if(buf[i] == ' ' || buf[i] == '\t') {
            if (pivot != -1) {
                args[arg_idx] = &buf[pivot];
                arg_idx++;
            }
            buf[i] = '\0';
            pivot = -1;
        }

        //Newline, found end of line, add pointer, null last arg and exit
        else if (buf[i] == '\n') {
         if (pivot != -1) {
               args[arg_idx] = &buf[pivot];
               arg_idx++;
            }
            buf[i] = '\0';
            args[arg_idx] = NULL;
            break;
        }

       //Update pivot index
        else if (pivot == -1) pivot = i;
        
        // Found &, raise is_concurrent flag so parent does not wait
        if (buf[i] == '&') {
            buf[i] = '\0';
            is_concurrent = 1;
        }
 
    }

    if (strcmp(args[0], "history") == 0) get_history();
    else update_history(hist_buf);
}

/* Checks whether current command is an alias and runs it */
void is_alias(char *args[]) {
    printf("index: %d\n", alias_idx); 
    printf("*%s*\n", args[0]); 
    for (int i=0; i<alias_idx; i++) {
        printf("HEY");
        printf("#%s#", alias_key[i]);
        // Conditional checks if alias exists
        if (strcmp(alias_key[i], args[0]) == 0) {
            char *args[MAX_LINE/2 + 1]; //Command line arguments
            len = strlen(alias_val[i]);
            //tokenize(args, alias_val[i], 1);
            

            //strcpy(args[0], alias_val[i]);
            //args[1] = NULL;
            
            execvp(args[0],args);
            exit(0);
        }
    }
}


/* Main shell interface gets user command and calls child process to run */
int main(void) {

    char *args[MAX_LINE/2 + 1]; //Command line arguments
    int should_run = 1; //Flag to determine when to exit program

    while(should_run) {
        printf("osh>");
        fflush(stdout); 
        char buf[MAX_LINE];  //Used to store user input
        is_concurrent = 0; //Reset concurrent flag 

        // Tokenize command parameters
        tokenize(args, buf, 0);

        // Alias command found, add alias
        if (strcmp(args[0], "alias") == 0 && args[1] != NULL) {
            // Insert alias key
            strcpy(alias_key[alias_idx], args[1]);

            char value[MAX_LINE];
            int i=2; int j=0;
            int val_idx = 0;
            
            // Extract Alias inside quotes
            while(args[i] != NULL) {
                j = 0;
                while (args[i][j] != '\0' && args[i][j] != '\n') {
                    if (args[i][j] != '\"') {
                        value[val_idx] = args[i][j];
                        val_idx++;
                    }
                    j++;
                }
                value[val_idx] = ' ';
                val_idx++;
                i++;
            }
            value[val_idx] = '\0';
           
            // Insert alias value and increment index
            strcpy(alias_val[alias_idx], value);
            alias_idx++;
            continue;
        }


        // Set path command found, change set new path environment
        if (strcmp(args[0], "set") == 0 && strcmp(args[1], "path") == 0 && strcmp(args[2], "=") == 0) { 
            char tmp[100];
            int i=3; int j=0;
            int tmp_idx = 0;
             
            //Parse Arguments and extract new path inside parentheses
            while(args[i] != NULL) {
                j = 0;
                while (args[i][j] != '\0' && args[i][j] != '\n') {
                    if (args[i][j] != '(' && args[i][j] != ')') {
                        tmp[tmp_idx] = args[i][j];
                        tmp_idx++;
                    }
                    j++;
                }
                tmp[tmp_idx] = ' ';
                tmp_idx++;
                i++;
            }
            tmp[tmp_idx] = '\0';
           
            // Get number of tokens
            int num_tokens=0;
            for(int k=0; tmp[k]!='\0';k++) {
                if (tmp[k] == ' ') num_tokens++;
            }

            // Tokenize path values
            char* new_args[MAX_LINE/2 + 1];
            tokenize(new_args, tmp, 1);

            // Concatenate into the form path1:path2:path3..etc
            char new_path[200];
            strcpy(new_path, new_args[0]);
            strcat(new_path, ":");
            for (int l=1; l<num_tokens; l++) {
                strcat(new_path, new_args[l]);
                strcat(new_path, ":");
            }           

            // Set new environment path
            setenv("PATH", new_path, 1);
            continue;
        }





        // (1) Fork a child process using fork
        pid_t pid;
        pid = fork();
       
        if (pid < 0) {
            printf("Failed to Fork.\n");
            return 1;
        }

        // Executed by Parent Process
        if (pid > 0) {
            int return_val;
            if (!is_concurrent) {
                // Wait on child process
                waitpid(pid, &return_val, 0);
            }
        }

        // (2) Child process will invoke execvp()
        if (pid == 0) {
            
            // Check if command is an alias first
            for (int i=0; i<alias_idx; i++) {
                // Conditional checks if alias exists
                if (strcmp(alias_key[i], args[0]) == 0) {
                    char *args2[MAX_LINE/2 + 1];

                    // Get length of string and number of spaces 
                    len = strlen(alias_val[i]);
                    int p = 0; int num_spaces = 0;
                    while (alias_val[i][p] != '\0') {
                        if (alias_val[i][p] == ' ' || alias_val[i][p] == '\t')
                            num_spaces++;
                        p++;
                    }
                   
                    // Tokenize string found in alias directory
                    tokenize(args2, alias_val[i], 1);

                    // NULL last argument and execute
                    args2[num_spaces] = NULL;
                    execvp(args2[0],args2);
                }
            }
        
            // Run execvp if command isn't a history call and len>0 
            if (strcmp(args[0], "history") != 0 && len > 0) {
                if (execvp(args[0], args) == -1) {
                    printf("No Command Found.\n");
                    //exit(0);
                }
            }
            exit(0);
        } 
    }
}

