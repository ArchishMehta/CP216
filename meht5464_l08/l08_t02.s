/*
-------------------------------------------------------
l08_t02.s
-------------------------------------------------------
Author: Archish Mehta
ID: 169065464
Email: meht5464@mylaurier.ca
Date:    2025-03-19
-------------------------------------------------------
Uses a subroutine to read strings from the UART into memory.
-------------------------------------------------------
*/
// Constants
.equ SIZE, 20 // Size of string buffer storage (bytes)

.org 0x1000   // Start at memory location 1000
.text         // Code section
.global _start
_start:

//=======================================================
// ReadString Sub
//=======================================================

ldr    r4, =First
bl    ReadString
ldr    r4, =Second
bl    ReadString
ldr    r4, =Third
bl     ReadString
ldr    r4, =Last
bl     ReadString

_stop:
b _stop

// Subroutine constants
.equ UART_BASE, 0xff201000  // UART base address
.equ ENTER, 0x0A            // The enter key code
.equ VALID, 0x8000          // Valid data in UART mask

ReadString:
/*
-------------------------------------------------------
Reads an ENTER terminated string from the UART.
-------------------------------------------------------
Parameters:
  r4 - address of string buffer
  r5 - size of string buffer
Uses:
  r0 - holds character to print
  r1 - address of UART
-------------------------------------------------------
*/

    stmfd sp!, {r0, r1, r2, r3, r4, r5} // save the registers
    ldr r1, =UART_BASE  // load the uart base address
    mov r2, #0  // initialize char count 
rsLOOP:
    ldr r0, [r1]    // raed from uart register
    tst r0, #VALID  // if valid data is availavle 
    beq rsEND   // if no data is availavle exit the sub 

    strb r0, [r4], #1   // store the char in buffer and move the pointer 
    add r2, r2, #1      // increment char count 
    cmp r2, r5  // check if the buffer is full
    beq rsEND   // if its full stop reading 
    cmp r0, #ENTER  // check for ENTER 
    beq rsEND   // if ENTER then stop reading 
    b   rsLOOP  //else continue reading

rsEND:
    mov r0, #0  // terminate the string 
    strb r0, [r4]   // store null at the end of buffer 
    ldmfd sp!, {r0, r1, r2, r3, r4, r5} // restore registers
    bx    lr                    // return from sub

.data
.align
// The list of strings
First:
.space  SIZE
Second:
.space SIZE
Third:
.space SIZE
Last:
.space SIZE
_Last:    // End of list address

.end