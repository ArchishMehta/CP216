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
.text        // Code part
.global _start
_start:

ldr    r2, =Data    // load address of start of list
ldr    r3, =_Data   // load address of end of list
ldr    r0, [r2], #4 // load first value from list
mov    r6, r0       // initialize min value to first value
mov    r7, r0       // initialize max value to first value

Loop:
cmp    r2, r3       // compare current address with end of list
beq    Done         // if u reach the end than finish

ldr    r0, [r2], #4 // load value from list and increment pointer
cmp    r0, r6       // compare value with current min
movlt  r6, r0       // if value is less than min than update min
cmp    r0, r7       // compare value with current max
movgt  r7, r0       // if value is greater than max than update max
b      Loop         // repeat loop

Done:
b      Done         // infinite loop to stop execution

.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12    // the list of data
_Data:  // end of list address

.end