/*
-------------------------------------------------------
list_demo.s
-------------------------------------------------------
Author:  Archish Mehta
ID:      169065464
Email:   meht5464@wlu.ca
Date:    2025-02-12
-------------------------------------------------------
A simple list demo program. Traverses all elements of an integer list.
r0: temp storage of value in list
r2: address of start of list
r3: address of end of list
-------------------------------------------------------
*/
.org 0x1000  // start at memory location 1000
.text        // code part
.global _start
_start:

ldr    r2, =Data    // load address of start of list
ldr    r3, =_Data   // load address of end of list
mov    r1, #0       // initialize the sum(r1) to 0

Loop:
cmp    r2, r3       // compare current address with end of list
beq    Done         // if u reach the end than finish

ldr    r0, [r2], #4 // load value from list and increment pointer
add    r1, r1, r0   // add value to sum
b      Loop         // repeat loop

Done:
b      Done         // infinite loop to stop execution

.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12    // the list of data
_Data:  // end of list address

.end