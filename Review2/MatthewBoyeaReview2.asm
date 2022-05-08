TITLE Review 2
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
varA DWORD 44448888h

.code
main PROC
	; 1. Write a sequence of MOV instructions which exchange the upper and lower words in
	; DWORD variable varA
	mov ax,WORD ptr varA
	mov bx,WORD ptr (varA + 2)
	mov WORD ptr varA,bx
	mov WORD ptr (varA + 2),ax
	; 2. Using the XCHG instruction no more than three times, reorder the values in four
	; 8-bit registers from the order A, B, C, D to B, C, D, A
	xchg al,bl
	xchg bl,cl
	xchg cl,dl
	; 3. Write two instructions that use addition to set the zero and carry flags at the
	; same time
	mov al,0FFh
	add al,1
	; 4. Write two instructions that set both the carry and overflow flags at the same time
	mov al,80h ; al=10000000
	add al,80h ; al+=10000000
	; 5. Write a sequence of instructions showing how the zero flag could be used to indicate
	; unsigned overflow after executing inc and dec instructions

	; exit
	invoke ExitProcess,0
main ENDP

END main