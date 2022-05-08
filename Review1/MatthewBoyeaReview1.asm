TITLE Review 1
; DESCRIPTION
; See Review PDF
; Author: Matthew Boyea
; Date: 2022-05-08

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

INCLUDE Irvine32.inc

.data
; 4. Create a variable named sum of type dword and initial value is 0
sum DWORD 0
; 6. Create a string "Good Morning" and name it as greeting
greeting BYTE "Good Morning",0
; 7. Create a DWORD array of 10 elements named smallArray with all elements initialized to be 1
smallArray DWORD 10 dup(1)
; 8. Write a statement that causes the assmebler to calulate the number of bytes in the following
; array and assign the value to a simbolic constant named ArraySize:
myArray WORD 20 dup(?)
ArraySize equ ($ - myArray)
; 9. Use TEXTEQU to assign the symbol SetupESI to the following line of code
SetupESI textequ <mov esi, offset myArray>
; 10. Declare a string variable containing the word "TEST" repeated 500 times
testStr BYTE 500 dup("TEST"),0
; 11. Show the order of individual bytes in memory (lowest to highest) for the following double
; word variable:
val1 DWORD 87654321h
; 21h 43h 65h 87h
; 12. Declare a 32-bit signed integer variable and initialize it with the smallest possible negative
; decimal value
smallest DWORD 80000000h
; 13. Declare an array of type BYTE and initialize it to the first 5 letters of the alphabet
alpha BYTE "abcde",0
; 14. Write 8-bit two's complement representation of number -5
negFive BYTE 11111010b

.code
main PROC
	; 1. Write one line of code to end the program
	; invoke ExitProcess,0
	; 2. Write one line of code to move hexadecimal number A6 to eax register
	mov eax,0A6h
	; 3. Write one line of code to add number 6 to eax register
	add eax,6
	; 5. Write one line of code to copy the contents of variable sum to eax
	mov eax,sum

	; exit
	invoke ExitProcess,0
main ENDP

END main