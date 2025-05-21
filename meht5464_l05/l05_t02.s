/*
-------------------------------------------------------
l05_t02.s
-------------------------------------------------------
Author: Archish Mehta
ID: 169065464
Email: meht5464@mylaurier.ca
Date:    2025-02-26
-------------------------------------------------------
Calculates stats on an integer list.
-------------------------------------------------------
*/

.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

mov    r1, #0       // Initialize counters
mov    r2, #0       
mov    r3, #0       
ldr    r4, =Data    // Store address of start of list
ldr    r5, =_Data   // Store address of end of list
bl     list_stats   // Call subroutine - total returned in r0

_stop:
b      _stop        // Infinite loop to end program

//-------------------------------------------------------
list_stats:
/*
-------------------------------------------------------
Counts number of positive, negative, and 0 values in a list.
Equivalent of: void stats(*start, *end, *zero, *positive, *negative)
-------------------------------------------------------
Parameters:
r1 - number of zero values
r2 - number of positive values
r3 - number of negative values
r4 - start address of list
r5 - end address of list
Uses:
r0 - temporary value
-------------------------------------------------------
*/
stmfd   sp!, {r4, r5, lr}   // save registers r4, r5, and return address lr

loop:
cmp     r4, r5              // check if reached the end of the list
beq     done                // if r4 == r5 exit loop

ldr     r0, [r4], #4        // load value at r4 into r0 then increment r4 by 4 (go to the next word)

cmp     r0, #0
beq     count_zero          // if value is 0 increment zero counter
blt     count_negative      // if value is negative increment negative counter

count_positive:
add     r2, r2, #1          // increment positive counter
b       loop                // continue looping

count_zero:
add     r1, r1, #1          // increment zero counter
b       loop                // continue looping

count_negative:
add     r3, r3, #1          // increment negative counter
b       loop                // continue looping

done:
ldmfd   sp!, {r4, r5, lr}   // restore registers r4, r5, and return address lr
bx      lr                  // return from subroutine

//-------------------------------------------------------
.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12    // The list of data
_Data:                          // End of list address

.end