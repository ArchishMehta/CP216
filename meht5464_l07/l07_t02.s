/*
-------------------------------------------------------
l07_t02.s
-------------------------------------------------------
Author: Archish Mehta
ID: 169065464
Email: meht5464@mylaurier.ca
Date:    2025-03-12
-------------------------------------------------------
Subroutines for determining if a string is a palindrome.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

// Test a string to see if it is a palindrome
ldr    r4, =Test1
ldr    r5, =_Test1 - 2
bl     PrintString
bl     PrintEnter
bl     Palindrome
bl     PrintTrueFalse
bl     PrintEnter

ldr    r4, =Test2
ldr    r5, =_Test2 - 2
bl     PrintString
bl     PrintEnter
bl     Palindrome
bl     PrintTrueFalse
bl     PrintEnter

ldr    r4, =Test3
ldr    r5, =_Test3 - 2
bl     PrintString
bl     PrintEnter
bl     Palindrome
bl     PrintTrueFalse
bl     PrintEnter

ldr    r4, =Test4
ldr    r5, =_Test4 - 2
bl     PrintString
bl     PrintEnter
bl     Palindrome
bl     PrintTrueFalse
bl     PrintEnter

_stop:
b    _stop

//-------------------------------------------------------

// Constants
.equ UART_BASE, 0xff201000     // UART base address
.equ ENTER, 0x0a     // enter character
.equ VALID, 0x8000   // Valid data in UART mask
.equ DIFF, 'a' - 'A' // Difference between upper and lower case letters

//-------------------------------------------------------
PrintChar:
/*
-------------------------------------------------------
Prints single character to UART.
-------------------------------------------------------
Parameters:
  r2 - address of character to print
Uses:
  r1 - address of UART
-------------------------------------------------------
*/
stmfd   sp!, {r1, lr}
ldr     r1, =UART_BASE  // Load UART base address
strb    r2, [r1]        // copy the character to the UART DATA field
ldmfd   sp!, {r1, lr}
bx      lr

//-------------------------------------------------------
PrintString:
/*
-------------------------------------------------------
Prints a null terminated string to the UART.
-------------------------------------------------------
Parameters:
  r4 - address of string
Uses:
  r1 - address of UART
  r2 - current character to print
-------------------------------------------------------
*/
stmfd   sp!, {r1-r2, r4, lr}
ldr     r1, =UART_BASE
psLOOP:
ldrb    r2, [r4], #1     // load a single byte from the string
cmp     r2, #0           // compare to null character
beq     _PrintString     // stop when the null character is found
strb    r2, [r1]         // else copy the character to the UART DATA field
b       psLOOP
_PrintString:
ldmfd   sp!, {r1-r2, r4, lr}
bx      lr

//-------------------------------------------------------
PrintEnter:
/*
-------------------------------------------------------
Prints the ENTER character to the UART.
-------------------------------------------------------
Uses:
  r2 - holds ENTER character
-------------------------------------------------------
*/
stmfd   sp!, {r2, lr}
mov     r2, #ENTER       // Load ENTER character
bl      PrintChar
ldmfd   sp!, {r2, lr}
bx      lr

//-------------------------------------------------------
PrintTrueFalse:
/*
-------------------------------------------------------
Prints "T" or "F" as appropriate
-------------------------------------------------------
Parameter
  r0 - input parameter of 0 (false) or 1 (true)
Uses:
  r2 - 'T' or 'F' character to print
-------------------------------------------------------
*/
stmfd   sp!, {r2, lr}
cmp     r0, #0           // Is r0 False?
moveq   r2, #'F'         // load "False" message
movne   r2, #'T'         // load "True" message
bl      PrintChar
ldmfd   sp!, {r2, lr}
bx      lr

//-------------------------------------------------------
isLowerCase:
/*
-------------------------------------------------------
Determines if a character is a lower case letter.
-------------------------------------------------------
Parameters
  r2 - character to test
Returns:
  r0 - returns True (1) if lower case, False (0) otherwise
-------------------------------------------------------
*/
mov    r0, #0           // default False
cmp    r2, #'a'
blt    _isLowerCase     // less than 'a', return False
cmp    r2, #'z'
movle  r0, #1           // less than or equal to 'z', return True
_isLowerCase:
bx lr

//-------------------------------------------------------
isUpperCase:
/*
-------------------------------------------------------
Determines if a character is an upper case letter.
-------------------------------------------------------
Parameters
  r2 - character to test
Returns:
  r0 - returns True (1) if upper case, False (0) otherwise
-------------------------------------------------------
*/
mov    r0, #0           // default False
cmp    r2, #'A'
blt    _isUpperCase     // less than 'A', return False
cmp    r2, #'Z'
movle  r0, #1           // less than or equal to 'Z', return True
_isUpperCase:
bx lr

//-------------------------------------------------------
isLetter:
/*
-------------------------------------------------------
Determines if a character is a letter.
-------------------------------------------------------
Parameters
  r2 - character to test
Returns:
  r0 - returns True (1) if letter, False (0) otherwise
-------------------------------------------------------
*/
bl      isLowerCase     // test for lowercase
cmp     r0, #0
bleq    isUpperCase     // not lowercase? Test for uppercase.
bx      lr

//-------------------------------------------------------
toLower:
/*
-------------------------------------------------------
Converts a character to lower case.
-------------------------------------------------------
Parameters
  r2 - character to convert
Returns:
  r2 - lowercase version of character
-------------------------------------------------------
*/
stmfd   sp!, {lr}
bl      isUpperCase      // test for upper case
cmp     r0, #0
addne   r2, #DIFF        // Convert to lower case
ldmfd   sp!, {lr}
bx      lr

//-------------------------------------------------------
Palindrome:
/*
-------------------------------------------------------
Determines if a string is a palindrome.
-------------------------------------------------------
Parameters
  r4 - address of first character of string to test
  r5 - address of last character of string to test
Uses:
  R? - ?
Returns:
  r0 - returns True (1) if palindrome, False (0) otherwise
-------------------------------------------------------
*/

//=======================================================

stmfd sp!, {r4,r5,r6,r7, lr} // preserve the registers

// recursive function
_palindrome_recursive:
    cmp r4, r5              // basecase - if r4>=r5 than return true
    bge _return_true

    // load the first char 
    ldrb r6, [r4]           // load chart at Ssart
    bl isLetter             // make sure it's a letter
    cmp r0, #0
    beq _skip_start         // if it isn't a letter, go to next

    // load the last char 
    ldrb r7, [r5]           // load the char at the end
    bl isLetter             // make sure it's a letter
    cmp r0, #0
    beq _skip_end        // if it isn't a letter, go backwards

    // make them all lowercase
    mov r2, r6 
    bl toLower
    mov r6, r2 
    mov r2, r7 
    bl toLower
    mov r7, r2
    
    // compare the first and last char 
    cmp r6,r7
    bne _return_false      // if they aren't the same return false

    // continue resusion 
    add r4,r4, #1 
    sub r5,r5, #1
    b _palindrome_recursive

    // skip non-letters
    _skip_start:
        add     r4, r4, #1  // move forward
        b       _palindrome_recursive

    _skip_end:
        sub     r5, r5, #1  // move backward
        b       _palindrome_recursive

    _return_true:
        mov     r0, #1      
        b       _palindrome_done

    _return_false:
        mov     r0, #0      

    _palindrome_done:
        ldmfd   sp!, {r4, r5, r6, r7, lr}  // restore registers
        bx      lr

//=======================================================

//-------------------------------------------------------
.data
Test1:
.asciz "otto"
_Test1:
Test2:
.asciz "RaceCar"
_Test2:
Test3:
.asciz "A man, a plan, a canal, Panama!"
_Test3:
Test4:
.asciz "David"
_Test4:

.end