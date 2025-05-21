/*
-------------------------------------------------------
l01.s
Assign to and add contents of registers.
-------------------------------------------------------
Author:  Archish Mehta
ID:      169065464
Email:   meht5464@wlu.ca
Date:    2025-01-07
-------------------------------------------------------
*/
.org    0x1000  // Start at memory location 1000
.text           // Code section
.global _start
_start:

mov R0, #9       // Store decimal 9 in register r0
mov R1, #14     // Store hex E (decimal 14) in register r1
mov R3, #8 		// Store decimal 8 in register r3
add R2, R1, R0  // Add the contents of r0 and r1 and put result in r2

mov R5, #5       // Load immediate value 5 into register R5
add R4, R5, #4   // Add the contents of R5 and immediate 4, store result in R4

// End program
_stop:
b   _stop