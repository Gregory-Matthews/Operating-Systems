/*   Class: CS 543 - Operating Systems
 * Project: Designing A Virtual Memory Manager
 *  Author: Gregory Matthews
 *    Date: 2/20/18
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

/* Global Constants */
#define P_ENTRY 256 // Page entries
#define P_SIZE 256 // Page size in bytes
#define TLB_ENTRY 16 //TLB Entries
#define F_SIZE 256 //Frame size in bytes
#define F_ENTRY 256 // Frame entries
#define M_SIZE 65536 //physical memory size

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
    FILE* disk = fopen("BACKING_STORE.bin", "r"); //Open Backing Store file

    /* Initialize variables */
    int logical_adr = 0; //Holds logical address
    int physical_adr = 0; //Holds physical address
    int physical_mem[M_SIZE]; //Physical memory
    int page_table[P_SIZE]; //Page table
    int page_num = 0; //Page number
    int frame_num = 0; //Frame number
    int page_offset = 0; //Page offset
    int tlb[2][TLB_ENTRY]; //TLB
    int tlb_time[TLB_ENTRY]; //Used to stored time of use for adress in TLB
    int tlb_counter=0; //Number of tlb addresses stored
    bool hit; //hit is 0 when address not found in tlb or page table
    char disk_buf[256]; //Hold read value from Backing Store
    int clock = 0; //Counter used for LRU algorithm

    /* Initialize all tables to -1, signifying null */
    memset(page_table, -1, P_ENTRY*sizeof(int));
    memset(tlb[0], -1, TLB_ENTRY*sizeof(int));
    memset(tlb[1], -1, TLB_ENTRY*sizeof(int));

    while(fscanf(in, "%d", &logical_adr)==1) {
        page_num = logical_adr >> 8; //get 8 MSBs from logical address
        page_offset = logical_adr & 255; //AND with 0b11111111
        

        // Check for address cached in tlb
        for (int i=0; i < sizeof(tlb[0])/sizeof(int); i++) {
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
        }


        // Else grab from disk
        else {
            page_table[page_num] = frame_num; //Add page table entry         
            
            // Read from Backing Store and put frame into physical memory
            fseek(disk, (page_num<<8), 0);
            fread(disk_buf, sizeof(char), F_SIZE, disk);
            for (int i=0; i< F_SIZE; i++) {
                physical_mem[(frame_num<<8)+i] = disk_buf[i];
            }

            // Update tlb, first check if not full
            if (tlb_counter < TLB_ENTRY) {
                tlb[0][tlb_counter] = page_num;
                tlb[1][tlb_counter] = page_table[page_num];
                tlb_time[tlb_counter] = clock; //Store current use time
            }
            
            // If tlb full, apply page replacement using LRU algorithm
            else {
                // Find LRU address
                int min = 0; int idx = 0; //clock value and index of LRU address
                for(int i=0; i<sizeof(tlb_time)/sizeof(int); i++) {
                    if (min == 0) min = tlb_time[i];
                    else if (min > tlb_time[i]) {
                        min = tlb_time[i];
                        idx = i;
                    }
                }
                // Overwrite LRU address with new address
                tlb[0][idx] = page_num;
                tlb[1][idx] = page_table[page_num];
                tlb_time[idx] = clock; //Store current use time
            }


            // Retrieve physical address
            physical_adr = (page_table[page_num]<<8) + page_offset;
        
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

