/*
-------------------------------------------------------
l02_t02.s
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
_start: // label used as markers for specific addresses in memory allowing the program to jump to them

// copy data from memory to registers 
ldr r3, =First  // load the memory address of "First" into r3
ldr r0, [r3]      // load the value at address r3 into r0 
ldr r3, =Second  // load the memory address of "Second" into r3 
ldr r1, [r3]    // load the value at address r3 into r1 

// preform arithemetics and store results in memory 
add r2, r0, r1  // add the value of r0 and r1 and store the value in r2
ldr r3, = Total   // load the memory address of "Total" into r3 
str r2, [r3]    // store the contents of r2 into the address in r3 (Total)

// subtract second from first
sub r2, r0, r1
ldr r3, =Diff  // load the memory address of "Diff" into r3 
str r2, [r3] // store the contents of r2 into the address in r3 (Diff)

// end program
.stop 
b _stop 

.data 
First: 
.word 4 
Second: 
.word 8 

.bss 
Total:
.space 4
Diff:
.space 4


