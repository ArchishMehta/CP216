/*
-------------------------------------------------------
l08_t03.s
-------------------------------------------------------
Author: Archish Mehta
ID: 169065464
Email: meht5464@mylaurier.ca
Date:    2025-03-19
-------------------------------------------------------
Uses a subroutine to read strings from the UART into memory.
-------------------------------------------------------
*/
.org 0x1000   // Start at memory location 1000
.text         // Code section
.global _start
_start:

bl    EchoString

_stop:
b _stop

// Subroutine constants
.equ UART_BASE, 0xff201000  // UART base address
.equ VALID, 0x8000          // Valid data in UART mask
.equ ENTER, 0x0A            // The enter key code

EchoString:
/*
-------------------------------------------------------
Echoes a string from the UART to the UART.
-------------------------------------------------------
Uses:
  r0 - holds character to print
  r1 - address of UART
-------------------------------------------------------
*/
    stmfd sp!, {r0, r1} // save the registers
    ldr r1, =UART_BASE  // load the uart base address

echoLOOP:
    ldr r0, [r1]    // read from uart register
    tst r0, #VALID  // check if the valid data is available 
    beq echoLOOP    // if no data then wait for an input 

    cmp r0, #ENTER  // check if char is ENTER 
    beq echoEND // if it is ENTER then exit 

    str r0, [r1]    // write the char back to uart 
    b echoLOOP  // repeat for next char 

echoEND:
    ldmfd sp!, {r0, r1} // restore registers 
    bx    lr               // return from subroutine

.end