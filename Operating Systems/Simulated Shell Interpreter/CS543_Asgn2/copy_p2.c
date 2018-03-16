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
int hist_idx = 0;

// Function used to display history of last 10 commands
void get_history(){
    for (int i=0; i<=hist_idx; i++) {
        printf("%s\n", history[i]);
    }
    
}

void update_history(char buf[]){
    strcpy(history[hist_idx], buf);
    hist_idx++;
}

/* Token function takes a char array as input and tokenizes it into args variable
 * Returns number of tokens */
int tokenize(char* args[], char buf[]) {

    char* token = strtok(buf, " \r\v\t");
    args[0] = token;

    int i=0;
    while(token != NULL) {
        args[i] = token;
        token = strtok(NULL, " \r\v\t");
        i++;
    }
    return i;
}

int tokenize2(char* args[], char buf[]) {
    int len = read(0, buf, MAX_LINE);
    
    /*
    if (buf[len-1] == '\n' && len > 0) {
        buf[len-1] = '\0';
    } */

    // Exception handling
    if (!len) {
        return -1;
    }
    else if (len < 0) {
        printf("Invalid Input.\n");
        return -1;
    }
        
    int arg_idx = 0;
    int pivot = -1;
    for (int i=0; i<len; i++) {
        if(buf[i] == ' ' || buf[i] == '\t' || buf[i] == '\n') {
            if (pivot != -1) {
                args[arg_idx] = &buf[pivot];
                pivot = i;
                arg_idx++;
                buf[i] = '\0';
                pivot = -1;
            }
            if (buf[i] == '\n') {
                args[arg_idx] = NULL;
                break;
            }
        }
        else if (pivot == -1) pivot = i;
    }

    return arg_idx;
    //args[0] = "ls\0";
    //args[1] = "-la\0";
    //args[2] = NULL;
}

int tokenize3(char inputBuffer[], char *args[],int *flag)
{
   	int length; // # of chars in command line
    	int start;  // index of beginning of next command
    	int ct = 0; // index of where to place the next parameter into args[]
    	//read user input on command line and checking whether the command is !! or !n
 	length = read(STDIN_FILENO, inputBuffer, MAX_LINE);	
    start = -1;
   //examine each character
    for (int i=0;i<length;i++)
    {
        switch (inputBuffer[i])
        {
            case ' ':
            case '\t' :               // to seperate arguments
                args[ct] = &inputBuffer[start];    
                ct++;
                inputBuffer[i] = '\0'; // add a null char at the end
                break;
                
            case '\n':                 //final char 
                args[ct] = &inputBuffer[start];
                ct++;
                inputBuffer[i] = '\0';
                args[ct] = NULL; // no more args
                break;
                
            default :           
                start = i;
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

        // Scanf using regular expression to read until \n, and discard the \n.
        int is_valid = 1;
        //int is_valid = scanf("%[^\n]%*c", buf);
        
        // Tokenize command parameters
        int *flag;
        tokenize2(args, buf);
        //tokenize3(buf, args, flag); 
        
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
            waitpid(pid, &return_val, 0);
        }

        // (2) Child process will invoke execvp()
        if (pid == 0) {
            
            //if (strcmp(args[0], "history") == 0) get_history();
            execvp(args[0], args);
            
            //update_history(buf);

        }






    
    }
}
