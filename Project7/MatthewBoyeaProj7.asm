TITLE Project 6
; DESCRIPTION
; Writes the product of variables lop and rop without using the mul instruction
; Author: Matthew Boyea
; Date: 2022-3-28

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

INCLUDE Irvine32.inc

STRING typedef BYTE
ADDRESS typedef DWORD
INTEGER typedef DWORD

.data
quitPrompt STRING "Press any key to quit...",0
lop INTEGER 11
rop INTEGER 7

.code
main PROC
	mov eax,lop
	mov ebx,rop
	call BitwiseMultiply
	call WriteInt
	call Crlf

	; wait for input
	mov edx,OFFSET quitPrompt
	call WriteString
	call ReadChar

	; exit program
	invoke ExitProcess,0
	ret
main ENDP

BitwiseMultiply PROC USES ebx ecx edx esi
	; RECEIVES
	; eax: left operator LOP
	; ebx: right operator ROP
	; RETURNS
	; eax: result in LOP
	; DESCRIPTION
	; Returns eax = eax * ebx without using mul instruction
	
	; copy LOP into stack
	push eax
	; clear eax
	mov eax,0
	; for every bit in ROP
	mov ecx,32 ; loop counter such that bit_index = ecx-1
L1:
	; shift ROP left such that the most significant bit is in CF
	shl ebx,1
	; if CF is set, jump to multiply by 2^(this bit's pos)
	jc MUL_ECX
C1:
	; loop to target the next bit
	loop L1
	; when loop is done, exit the procedure
	jmp QUITPROC
MUL_ECX:
	; copy LOP from stack into edx
	mov edx,[esp]
	; decrement ecx such that it represents the bit's pos
	dec ecx
	; edx = edx * 2^(this bit's pos)
	shl edx,cl
	; add the result to eax
	add eax,edx
	; increment ecx to return it to its original value
	inc ecx
	; jump back into the loop's condition
	jmp C1
QUITPROC:
	; remove LOP from the stack
	pop ecx
	; return
	ret
BitwiseMultiply ENDP

END main