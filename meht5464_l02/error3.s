/*
-------------------------------------------------------
errors3.s
-------------------------------------------------------
Author: Archish Mehta 
ID: 169065464
Email: meht5464@mylaurier.ca
Date: Jan 15th, 2025
-------------------------------------------------------
Copies contents of one vector to another.
-------------------------------------------------------
*/
.org 0x1000 // start at memory location 1000
.text       // code section

.global _start 
_start: // label used as markers for specific addresses in memory allowing the program to jump to them

// copy contents of first element of Vec1 to Vec2 
ldr r0, = Vec1  // load the address of Vec1 into r0
ldr r1, = Vec2  // load the address of Vec2 into r1 
ldr r2, [r0]    // load the first element of Vec1 into r2
str r2, [r1]    // store the value of r2 into the first element of Vec2

// copy contents of second element of Vec1 to Vec2
add r0, r0, #4  // move to the second element of Vec1 (4 bytes ahead)
add r1, r1, #4  // move to the second element of Vec2 (4 bytes ahead)
ldr r2, [r0]      // load the second element of Vec1 into r2
str r2, [r1]      // store the value of r2 into the second element of Vec2

// copy contents of the third element of Vec1 to Vec2
add r0, r0, #4  // move to the second element of Vec1 (4 bytes ahead)
add r1, r1, #4  // move to the second element of Vec2 (4 bytes ahead)
ldr r2, [r0]      // load the second element of Vec1 into r2
str r2, [r1]      // store the value of r2 into the second element of Vec2

// end program
_stop:
b _stop           // end the program

// initialized data section
.data  
Vec1:
.word 1, 2, 3     // define a word vector with values 1, 2, 3

Vec2:
.space 12         // set aside 12 bytes (3 words) for Vec2

.end