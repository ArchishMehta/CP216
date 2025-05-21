/*
-------------------------------------------------------
meht5464_A2.s
-------------------------------------------------------
Author:  Archish Mehta
ID:      169065464
Email:   meht5464@mylaurier.ca
Date:    2025-02-27
-------------------------------------------------------
A program that converts hexadecimal numbers to ASCII.
-------------------------------------------------------
*/
.org 0x1000  // start at memory location 1000
.text        // code section
.global _start

_start:
    mov    r3, #16          // number of elements in Data array
    ldr    r0, =Data        // load address of Data array
    ldr    r1, =0x00001500  // destination address for ASCII codes
    ldr    r2, =lookup_table // load address of lookup table

Loop:
    ldr    r4, [r0], #4     // load a word from Data and increment pointer
    ldrb   r5, [r2, r4]     // get ASCII equivalent from lookup table
    strb   r5, [r1], #1	    // store byte in r5 at address in r1, then increment r1 by 1	
    subs   r3, r3, #1       // decrement counter
    bne    Loop             // repeat until all elements are processed

_stop:
    b _stop                 // infinite loop to stop execution

.data
.align
Data:
.word 0xA, 0xB, 0xC, 0x1, 0x2, 0x4, 0x9, 0x3
.word 0xD, 0xF, 0xE, 0x7, 0x5, 0x6, 0x8, 0x0
_Data:

lookup_table:
.byte 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37
.byte 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46

.end
