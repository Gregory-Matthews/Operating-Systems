/*   Class: CS 543 - Operating Systems
 * Project: Designing A Virtual Memory Manager
 *  Author: Gregory Matthews
 *    Date: 2/24/18
 */

/* Modification: Using 128 frames to replicate small physical memory */
/* Modification2: Incorporating read/write conditions by using dirty bit */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

/* Global Constants */
#define P_ENTRY 256 // Page entries
#define P_SIZE 256 // Page size in bytes
#define TLB_ENTRY 16 //TLB Entries
#define F_SIZE 256 //Frame size in bytes
#define F_ENTRY 128 // Frame entries
#define M_SIZE 32768 //physical memory size

/* Variables used for gathering statistics */
int num_addresses = 0; //# of addresses checked
int num_hits = 0; //# of tlb hits
int num_faults = 0; //# of page faults


/* Main program, Simulates Virtual Memory Manager by converting 
 * Logical Addresses to Physical Addresses and reading its value */
int main(int argc, char* argv[]) {
    /* Error Checking */
    if (argc != 2) {
        printf("Incorrect number of parameters.\n");
        exit(1);
    }

    FILE* in = fopen(argv[1], "r"); // Address file
    FILE* out = fopen("results.txt", "w"); //Write results to file
    FILE* disk = fopen("BACKING_STORE.bin", "r+b"); //Open Backing Store file

    /* Initialize variables */
    int logical_adr = 0; //Holds logical address
    char logical_str[32]; //Holds logical address string
    int physical_adr = 0; //Holds physical address
    int physical_mem[M_SIZE]; //Physical memory
    int physical_time[F_ENTRY]; //Store last time used in physical memory
    int page_table[P_ENTRY]; //Page table
    bool page_dirty[P_ENTRY]; //Page Dirty Bits
    int page_num = 0; //Page number
    int frame_num = 0; //Frame number
    int page_offset = 0; //Page offset
    int tlb[2][TLB_ENTRY]; //TLB
    int tlb_time[TLB_ENTRY]; //Used to stored time of use for adress in TLB
    int tlb_counter=0; //Number of tlb addresses stored
    bool tlb_dirty[TLB_ENTRY]; //TLB Dirty Bits
    bool hit; //hit is 0 when address not found in tlb or page table
    char disk_buf[256]; //Hold read value from Backing Store
    int clock = 0; //Counter used for LRU algorithm
    int min; int idx; //used for storing LRU clock value and index
    bool full=0; //flag for when physical memory is full
    bool tlb_full=0; //flag for when tlb is full
    char type; // Whether reading or writing address

    /* Initialize all tables to -1, signifying null, 0 for Dirty bits */
    memset(page_dirty,  0, P_ENTRY*sizeof(int));
    memset(tlb_dirty,  0, TLB_ENTRY*sizeof(int));
    memset(page_table, -1, P_ENTRY*sizeof(int));
    memset(tlb[0], -1, TLB_ENTRY*sizeof(int));
    memset(tlb[1], -1, TLB_ENTRY*sizeof(int));
    memset(physical_time, -1, F_ENTRY*sizeof(int));
    memset(tlb_time, -1, TLB_ENTRY*sizeof(int));

    // Iterate through all logical addresses from file
    while(fgets(logical_str, 32, in) != NULL) {
       
        // Find if logical address is R/W & remove parameter from address
        char temp[32];
        for(int i=0; i<strlen(logical_str);i++) {
            if (logical_str[i] == 'R') {
                type = 'R';
                logical_str[i-1] = '\0';
            }
            else if (logical_str[i] == 'W') {
                type = 'W';
                logical_str[i-1] = '\0';
            }
        }
        // Convert parsed address to int
        logical_adr = atoi(logical_str);

        page_num = logical_adr >> 8; //get 8 MSBs from logical address
        page_offset = logical_adr & 255; //AND with 0b11111111
        

        // Check for address cached in tlb
        for (int i=0; i < sizeof(tlb[0])/sizeof(int); i++) {
            // If hit, grab from tlb
            if (tlb[0][i] == page_num) {
                hit = 1;
                num_hits++;
                physical_adr = (tlb[1][i] << 8) + page_offset;
            }
            else hit=0;
        }

        // If not a hit in tlb, check page table
        if (!hit & page_table[page_num] != -1) {
            physical_adr = (page_table[page_num] << 8) + page_offset; 
            physical_time[page_table[page_num]] = clock; //update reference time
        }

        // Page fault, grab from disk
        else {
        
            // Read from Backing Store and get corresponding page
            fseek(disk, (page_num<<8), 0);
            fread(disk_buf, sizeof(char), F_SIZE, disk);
          
            // Check if there are any free page frames
            if(frame_num >= F_ENTRY) full = 1;
            if (!full) {
                page_table[page_num] = frame_num; //Update page table entry 
                if (type == 'W') page_dirty[page_num] = 1; // Modify bit set
                if (type == 'R') page_dirty[page_num] = 0; // Modify bit set
            }

            // Find victim frame using LRU by finding min clock cycle
            else {
                min=0;
                for(int i=0; i<sizeof(physical_time)/sizeof(int); i++) {
                    if (physical_time[i] != -1) {
                        if (min == 0) {
                            min = physical_time[i];
                            frame_num = i;
                        }
                        else if (min > physical_time[i]) {
                            min = physical_time[i];
                            frame_num = i;
                        }
                    }
                }

            // Find page corresponding to victim frame
            int victim = 0;
            for (int i=0; i<sizeof(page_table)/sizeof(int);i++) {
                if(page_table[i] == frame_num) victim = i;
            }

            // Has dirty bit, must write back value in memory to disk
            if (page_dirty[victim]) {
    
                // Get value from main memory at victim address
                char val[256];
                int adr = (page_table[victim]<<8) + page_offset;
                for (int i=0; i<F_SIZE;i++) val[i] = physical_mem[adr+i];
                    
                // Write back to disk
                fseek(disk, (victim<<8), 0);
                fwrite(val, sizeof(char), F_SIZE, disk);
            }

            // Invalidate page table entry
            page_table[victim] = -1;
            
            page_table[page_num] = frame_num; //Update page table entry  
            if (type == 'W') page_dirty[page_num] = 1; // Modify bit set
            if (type == 'R') page_dirty[page_num] = 0; // Modify bit set
        }
            
        // Get value from disk and put into physical memory
        for (int i=0; i< F_SIZE; i++) {
            physical_mem[(page_table[page_num]<<8)+i] = disk_buf[i];
        }

        physical_time[page_table[page_num]] = clock; //update reference time
            
        // Retrieve physical address
        physical_adr = (page_table[page_num]<<8) + page_offset;
            
        // Update tlb, first check if not full
        if (tlb_counter > TLB_ENTRY) tlb_full=1;
        if (!tlb_full) {
            tlb[0][tlb_counter] = page_num;
            tlb[1][tlb_counter] = page_table[page_num];
            tlb_time[tlb_counter] = clock; //Store current use time
            
            if (type == 'W') tlb_dirty[tlb_counter] = 1; // Modify bit set
            if (type == 'R') tlb_dirty[tlb_counter] = 0; // Modify bit set
        }
            
        // If tlb full, apply page replacement using LRU algorithm
        else {
            // Find victim address using LRU
            min = 0; idx = 0; //clock value and index of LRU address
            for(int i=0; i<sizeof(tlb_time)/sizeof(int); i++) { 
                if (tlb_time[i] != -1) {
                    if (min == 0) min = tlb_time[i];
                    else if (min > tlb_time[i]) {
                        min = tlb_time[i];
                        idx = i;
                    }
                }
            }

            // Has dirty bit, must write back to disk
            if (tlb_dirty[idx]) {

                // Get value from main memory at victim address
                char val[256];
                int adr = (tlb[1][idx] << 8) + page_offset;
                for (int i=0; i<F_SIZE;i++) val[i] = physical_mem[adr+i];
                    
                // Write back to disk
                fseek(disk, (tlb[0][idx]<<8), 0);
                fwrite(val, sizeof(char), F_SIZE, disk);
            }

            // Overwrite LRU address with new address
            tlb[0][idx] = page_num;
            tlb[1][idx] = page_table[page_num];
            tlb_time[idx] = clock; //Store current use time
            if (type == 'W') tlb_dirty[idx] = 1; // Modify bit set
            if (type == 'R') tlb_dirty[idx] = 0; // Modify bit set
        }
        
        // Update counters
        frame_num++;
        num_faults++;
        tlb_counter++;
    }

    fprintf(out, "Virtual Address: %d Physical Address: %d Value: %d\n", logical_adr, physical_adr, physical_mem[physical_adr]);
    
        
    clock++; // increment simulated clock
    num_addresses++; //increment count of addresses
}

fprintf(out, "Page Fault Rate: %.4f\n", (float)num_faults/num_addresses); 
fprintf(out, "TLB Hit Rate: %.4f\n", (float)num_hits/num_addresses); 

// Closing Files
fclose(in);
fclose(out);
fclose(disk);

}

