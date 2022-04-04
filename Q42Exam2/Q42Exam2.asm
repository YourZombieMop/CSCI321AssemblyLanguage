TITLE Q43Exam2
; DESCRIPTION
; Implement the following pseudocode in assembly language.
; Use short-circuit evaluation and  assume that val1 and X are 32-bit variables.
; if(val1 > ecx AND ecx > edx) X = 1  else X = 2
; Author: Matthew Boyea
; Date: 2022-4-4

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
X DWORD ?
val1 DWORD 3

.code
main PROC
	mov ecx,2
	mov edx,1
	; if (val1 > ecx AND ecx > edx) X = 1 else X = 2

	; if (val1 <= ecx) goto Otherwise
	cmp val1,ecx
	jbe Otherwise

	; if (ecx <= edx) goto Otherwise
	cmp ecx,edx
	jbe Otherwise

	; X = 1
	mov X,1
	jmp Finish

Otherwise:
	; X = 2
	mov X,2
Finish:

	; exit program
	invoke ExitProcess,0
main ENDP

END main