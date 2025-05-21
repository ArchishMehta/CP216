/*
-------------------------------------------------------
l08_t01.s
-------------------------------------------------------
Author: Archish Mehta
ID: 169065464
Email: meht5464@mylaurier.ca
Date:    2025-03-19
-------------------------------------------------------
Uses a subroutine to write strings to the UART.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

ldr r4, =First
bl  WriteString
ldr r4, =Second
bl  WriteString
ldr r4, =Third
bl  WriteString
ldr r4, =Last
bl  WriteString

_stop:
b    _stop

// Subroutine constants
.equ UART_BASE, 0xff201000  // UART base address
.equ ENTER, 0x0A

//=======================================================
//WriteString Subroutine
//=======================================================

WriteString:
/*
-------------------------------------------------------
Writes a null-terminated string to the UART, adds ENTER.
-------------------------------------------------------
Parameters:
  r4 - address of string to print
Uses:
  r0 - holds character to print
  r1 - address of UART
-------------------------------------------------------
*/
    stmfd sp!, {r0, r1, r4} // save the registers
    ldr r1, =UART_BASE  // load uart base address 

wsLOOP:
    ldrb r0, [r4], #1   // load byte from string and move the pointer
    cmp r0, #0  // check for null 
    beq wsEND   // if null exit the loop 
    str r0, [r1]    // send the char to uart
    b wsLOOP    // loop again
    
wsEND:
    mov r0, #ENTER  // load enter char 
    str r0, [r1]    // send enter to uart
    ldmfd sp!, {r0, r1, r4}     // restore the registers
    bx    lr                 // return from subroutine

.data
.align
// The list of strings
First:
.asciz  "First string"
Second:
.asciz  "Second string"
Third:
.asciz  "Third string"
Last:
.asciz  "Last string"
_Last:    // End of list address

.end