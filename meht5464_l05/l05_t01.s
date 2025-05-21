/*
-------------------------------------------------------
l05_t01.s
-------------------------------------------------------
Author: Archish Mehta
ID: 169065464
Email: meht5464@mylaurier.ca
Date:    2024-02-21
-------------------------------------------------------
Does a running total of an integer list.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

ldr    r1, =Data    // Store address of start of list
ldr    r2, =_Data   // Store address of end of list
bl     list_total   // Call subroutine - total returned in r0

_stop:
b      _stop

//-------------------------------------------------------
list_total:
/*
-------------------------------------------------------
Totals values in a list.
Equivalent of: int total(*start, *end)
-------------------------------------------------------
Parameters:
  r1 - start address of list
  r2 - end address of list
Uses:
  r3 - temporary value
Returns:
  r0 - total of values in list
-------------------------------------------------------
*/

list_total:
mov     r0, #0          // initialize sum to 0

loop:
cmp     r1, r2          // check if start address has reached end address
beq     done            // if equal than exit loop

ldr     r3, [r1], #4    // load value from memory at r1 then increment r1 by 4(getting to the next word)
add     r0, r0, r3      // add value in r3 to sum (r0)
b       loop            // repeat loop

done:
bx      lr              // return from subroutine

.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12    // The list of data
_Data: // End of list address

.end