/* CS 543: Assignment 2
 * Author: Gregory Matthews
 * Last Modified: 1/31/18
 */
#include<stdio.h>
#include<unistd.h>
#include<string.h>
#include<sys/wait.h>
#define MAX_LINE 80 /*Maximum length commands */
char history[10][MAX_LINE];
char hist_buf[MAX_LINE];
int hist_idx = 0; //history indexing 1-10
int len; //length of argument field
int is_concurrent = 0; // flag for allowing concurrent processing

/// Function used to display history of last 10 commands
void get_history(){
    int len;
    if (hist_idx == 0) return;
     
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

/* Token function takes a char array as input and tokenizes it into args variable
 * Returns number of tokens */
void tokenize(char* args[], char buf[]) {
    // Reading in standard info
    len = read(0, buf, MAX_LINE);

    // Exception handling
    if (len < 2) {
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
            printf("%d", n);
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
        tokenize(args, buf);
        
        /*
        int i=0;
        while(args[0][i] != '\n' && args[0][i] != '\0') {
            printf("%c", args[0][i]);
            i++;
        } */

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
                waitpid(pid, &return_val, 0);
            }
        }

        // (2) Child process will invoke execvp()
        if (pid == 0) {
            if(len > 0) execvp(args[0], args);
        }
    }
}
