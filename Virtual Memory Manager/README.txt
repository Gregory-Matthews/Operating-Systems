Author: Gregory Matthews
Title: Virtual Memory Manager
Date: 2/24/17

File Contents:
-------------------------------------------------------------------------------------------
1.) vmm folder:
	vmm.c 			: source code for the virtual memory manager.
	addresses.txt		: input parameter file of logical addresses.
	results.txt		: shows converted logical to physical addresses, 
				  value stored at the address, and the page fault
				  rate and tlb hit rate.
	BACKING_STORE.bin	: binary file representing the disk, holds the values to be addressed.

2.) vmm_mod folder:
	vmm_mod.c 		: source code for the virtual memory manager including
				  modification of smaller physical mem (128 Frames) uses
				  LRU technique for page replacement.
	addresses.txt		: input parameter file of logical addresses.
	results.txt		: shows converted logical to physical addresses, 
				  value stored at the address, and the page fault
				  rate and tlb hit rate.
	BACKING_STORE.bin	: binary file representing the disk, holds the values to be addressed.

3.) vmm_mod2 folder:
	vmm_mod2.c 		: source code for the virtual memory manager including.
				  modification of smaller physical mem (128 Frames) uses
				  LRU technique for page replacement. Adds read/write handling
				  using dirty bits for page table and tlb.
	addresses2.txt		: input parameter file of logical addresses with read/write indication.
	results.txt		: shows converted logical to physical addresses, 
				  value stored at the address, and the page fault
				  rate and tlb hit rate.
	BACKING_STORE.bin	: binary file representing the disk, holds the values to be addressed.

4.) Homework3_Questions.pdf	: pdf file that answers supplementary questions as part of the homework assignment


Description:
-------------------------------------------------------------------------------------------
The assignment is in regards to Programming Projects: Designing a Virtual Memory Manager
from the book "Operating Systems Projects 9th Edition" by Abraham Silberchatz. (pg. 458-461)
The source code (vmm.c) is in direct reference to the project assignment, with (vmm_mod) 
answering the modification functionality. (vmm_mod2) extends this further by handling read/write
conditions by incorporating a dirty bit to pages and tlb entries.

How to Run: (vmm.c)
--------------------------------------------------------------------------------------------
 1.) In the terminal, go into folder: /vmm
 2.) Type into the terminal: gcc vmm.c -std=c99
 4.) Execute the program by typing: ./a.out addresses.txt
 5.) The results.txt file will be populated with the vmm's statistics.

How to Run: (vmm_mod.c)
--------------------------------------------------------------------------------------------
 1.) In the terminal, go into folder: /vmm_mod
 2.) Type into the terminal: gcc vmm_mod.c -std=c99
 4.) Execute the program by typing: ./a.out addresses.txt
 5.) The results.txt file will be populated with the vmm's statistics.

How to Run: (vmm_mod2.c)
--------------------------------------------------------------------------------------------
 1.) In the terminal, go into folder: /vmm_mod2
 2.) Type into the terminal: gcc vmm_mod2.c -std=c99
 4.) Execute the program by typing: ./a.out addresses2.txt
 5.) The results.txt file will be populated with the vmm's statistics.

Note:
---------------------------------------------------------------------------------------------
Page Fault Rate and TLB Hit Rate are shown at the very bottom of results.txt file.