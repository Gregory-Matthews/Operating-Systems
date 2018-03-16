// Gregory Matthews
// CS 543 - Homework 1 - Assignment II

#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/list.h> //Includes list
#include <linux/types.h> //Includes list_head structure
#include <linux/slab.h> //Includes kmalloc

struct birthday {
    int day;
    int month;
    int year;
    struct list_head list;
}birthday;

static LIST_HEAD(birthday_list); 
struct birthday *person; // Used as pointer to person w/ Birthday
struct birthday *ptr; // Pointer used for list travseral
struct birthday *next; // Pointer used to maintain value of next pointer 
int i;

/* This function is called when the module is loaded. */
int birthday_init(void)
{
    printk(KERN_INFO "Loading Module\n");


    // Creating 5 Birthday Elements
    for (i = 0; i <5; i++) {

        // Inserting elements into Linked List
        person = kmalloc(sizeof(*person), GFP_KERNEL);
        person->day = 2+i;
        person->month = 8+i;
        person->year = 1995-2*i;
        INIT_LIST_HEAD(&person->list); //Initializes list member in birthday
        list_add_tail(&person->list, &birthday_list);
    }

    // Traverse the Linked List

    list_for_each_entry(ptr, &birthday_list, list) {
        printk(KERN_INFO "Birthdate: %d/%d/%d\n", ptr->month, ptr->day, ptr->year); 
    }
    

    return 0;
}

/* This function is called when the module is removed. */
void birthday_exit(void) {
    printk(KERN_INFO "Removing Module\n");
    
    //Remove all elements from Linked List
    list_for_each_entry_safe(ptr, next, &birthday_list, list) {
        list_del(&ptr->list);
        printk(KERN_INFO "Freeing Birthday: %d/%d/%d\n", ptr->month, ptr->day, ptr->year);
        kfree(ptr);
    }
}

/* Macros for registering module entry and exit points. */
module_init( birthday_init );
module_exit( birthday_exit );

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Birthday Module");
MODULE_AUTHOR("SGG");


