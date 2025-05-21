/*
-------------------------------------------------------
errors1.s
-------------------------------------------------------
Author: Archish Mehta
ID: 169065464
Email: meht5464@mylaurier.ca
Date: Jan 15th, 2025
-------------------------------------------------------
Assign to and add contents of registers.
-------------------------------------------------------
*/
.org 0x1000 // start at memory location 1000
.text       // code section

.global _start  
_start:     // label used as markers for specific addresses in memory allowing the program to jump to them

// copy data from memory to registers
ldr r3, =A      // load the address of A into r3 
ldr r0, [r3]    // load the value at the adress of r3 into r0
ldr r3, = B     // load the address of B into r3 
ldr r1, [r3]    // load the value at the adress of r3 into r1
add r2, r1, r0  // add the values at r1 and r0 and store that into r2

// copy data to memory 
ldr r3, =Result // load the address of the result into r3 
str r2, [r3]    // store contents of r2 to address in r3

// end program 
_stop:      // label used as markers for specific addresses in memory allowing the program to jump to them
b _stop

// initialized data section
.data       // tells the assembler that the following section is for initialized data
A:      // variable
.word 4   // reserves 4 bytes (1 word) of memory and initializes it with the value 4
B: 
.word 8

// uninitialized data section
.bss 
Result 
.space 4    // set aside 4 bytes for result

.end
