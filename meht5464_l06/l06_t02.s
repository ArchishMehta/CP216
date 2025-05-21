/*
-------------------------------------------------------
l06_t02.s
-------------------------------------------------------
Author: Archish Mehta
ID: 169065464
Email: meht5464@mylaurier.ca
Date:    2025-03-06
-------------------------------------------------------
Working with stack frames.
Find minimum and maximum values in a list.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

//=======================================================

ldr    r0, =Data    
ldr    r1, =_Data   
ldr    r2, =Min     
ldr    r3, =Max    

// Push parameters onto stack (in reverse order)
stmfd  sp!, {r3}    
stmfd  sp!, {r2}    
stmfd  sp!, {r1}    
stmfd  sp!, {r0}    
bl     MinMax     
add    sp, sp, #16

//=======================================================

_stop:
b    _stop

//-------------------------------------------------------
MinMax:
/*
-------------------------------------------------------
Finds the minimum and maximum values in a list.
Equivalent of: MinMax(*start, *end, *min, *max)
Passes addresses of list, end of list, max, and min as parameters.
-------------------------------------------------------
Parameters:
  start - start address of list
  end - end address of list
  min - address of minimum result
  max - address of maximum result
Uses:
  r0 - address of start of list
  r1 - address of end of list
  r2 - minimum value so far
  r3 - maximum value so far
  r4 - address of value to process
-------------------------------------------------------
*/
stmfd   sp!, {fp, lr}   
mov     fp, sp          

ldr     r0, [fp, #8]    
ldr     r1, [fp, #12]   
ldr     r2, [r0]        
ldr     r3, [r0]        
add     r0, r0, #4    

MinMaxLoop:
cmp    r0, r1           // Compare addresses
beq    _MinMax
ldr    r4, [r0], #4
cmp    r4, r2
movlt  r2, r4
cmp    r4, r3
movgt  r3, r4
b      MinMaxLoop

_MinMax:
// Store results to address parameters
ldr    r0, [fp, #16]
str    r2, [r0]         // store minimum
ldr    r0, [fp, #20]
str    r3, [r0]         // store maximum

ldmfd  sp!, {fp,lr}     // pop preserved registers
// deallocate local storage (none was allocated)
ldmfd   sp!, {fp}       // pop frame pointer
bx      lr              // return from subroutine

//-------------------------------------------------------
.data  // Data section
.align
Data:
.word    4,5,-9,0,3,0,8,-7,12    // The list of data
_Data:    // End of list address
Min:
.space 4
Max:
.space 4

.end