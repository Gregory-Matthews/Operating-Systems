Author: Gregory Matthews
Date: 1/11/17

Description:
This file contains the source code and Makefiles for Assignment I and II from Ch. 2
as well as a word document answering some of the supplemental questions for the assignment.
Screenshots of the kernel log buffer for both assignments are also given in this file.

How to Run:
-AssignmentI
	1.) Go into AssignmentI folder
	2.) run "make" on the command line to generate necessary files
	3.) run "sudo insmod simple.ko" to insert the kernel module
	4.) run "sudo rmmod simple" to remove the kernel module
	5.) Screenshot of dmesg log is shown by "AssignmentI dmesg.png"

-AssignmentII
	1.) Go into AssignmentII folder
	2.) run "make" on the command line to generate necessary files
	3.) run "sudo insmod birthday.ko" to insert the kernel module
	4.) run "sudo rmmod birthday" to remove the kernel module
	5.) Screenshot of dmesg log is shown by "AssignmentI dmesg.png"

-Question1 (Simulation)
	1.) Go into Crash folder.
	2.) run "make" on the command line to generate necessary files
	3.) run sudo slabtop to see what is allocated in memory
	4.) run "sudo insmod crash.ko" to insert the kernel module
	5.) run sudo slabtop again and see the huge increase in memory size
	6.) run "sudo rmmod crash" to remove the kernel module
	7.) run sudo slabtop and notice that the allocated memory is still
	    being used because I didn't kfree() the elements when finished.
	
	

