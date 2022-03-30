TITLE Project 6
; DESCRIPTION
; Provides an operation menu which allows the user to perform simple
; boolean operations on 32 bit hexadecimal integers.
; It supports the following operations for inputs X and Y:
; X AND Y
; X OR Y
; NOT X
; X XOR Y
; Author: Matthew Boyea
; Date: 2022-3-28

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

INCLUDE Irvine32.inc

STRING typedef BYTE
ADDRESS typedef DWORD

.data
resultStatement STRING "Result of operation (32-bit hexadecimal): ",0
firstInputPrompt STRING "Input the first 32-bit value in hexadecimal: ",0
nextInputPrompt STRING "Input the next 32-bit value in hexadecimal: ",0
continuePrompt STRING "Press any key to continue...",0
quitPrompt STRING "Press any key to quit...",0
opMenuPrompt STRING "PROJ 6: Boolean Calculator",13,10,
                    13,10,
                    "1: x AND y",13,10,
                    "2: x OR y",13,10,
                    "3: x XOR y",13,10,
                    "4: NOT x",13,10,
                    "OTHER: quit program",13,10,
                    13,10,
                    "Input integer: ",0
opTable STRING '1'     ; opKey
        ADDRESS op_AND ; opAddress
OP_TABLE_ENTRY_SIZE equ ($ - opTable)
        STRING '2'
        ADDRESS op_OR
        STRING '3'
        ADDRESS op_XOR
        STRING '4'
        ADDRESS op_NOT
OP_TABLE_LEN equ (($ - opTable) / OP_TABLE_ENTRY_SIZE)

.code
main PROC
L1:
	; print menu
	mov edx,OFFSET opMenuPrompt
	call WriteString
	; read char into al
	call ReadChar
	call WriteChar
	call Crlf
	call Crlf

	; point esi to first opKey in opTable
	mov esi,OFFSET opTable
	mov ecx,OP_TABLE_LEN
L2:
	; if (al != esi*) Continue
	cmp al,[esi]
	jne L2_Continue
	; else call opAddress and Break
	call NEAR PTR [esi + SIZEOF STRING]
	jmp L2_Break
L2_Continue:
	; point esi to next opKey in opTable
	add esi,OP_TABLE_ENTRY_SIZE
	; loop if (ecx != 0)
	loop L2
	; else quit opMenu
	jmp L1_Break
L2_Break:
L1_Continue:
	; wait for input
	mov edx,OFFSET continuePrompt
	call WriteString
	call ReadChar
	; reset console
	call Clrscr
	jmp L1
L1_Break:

	; wait for input
	mov edx,OFFSET quitPrompt
	call WriteString
	call ReadChar

	; exit program
	invoke ExitProcess,0
	ret
main ENDP

op_AND PROC USES EAX EBX EDX
	; DESCRIPTION
	; Prompts the user for two 32 bit hexadecimal integers, LOP and ROP.
	; Print the result of (LOP & ROP).

	; print first input prompt
	mov edx,OFFSET firstInputPrompt
	call WriteString
	; read LOP into eax
	call ReadHex
	; copy LOP to ebx
	mov ebx,eax
	
	; print next input prompt
	mov edx,OFFSET nextInputPrompt
	call WriteString
	; read ROP into eax
	call ReadHex

	; calculate result
	AND eax,ebx
	; print result
	mov edx,OFFSET resultStatement
	call WriteString
	call WriteHex
	call Crlf
	call Crlf
	ret
op_AND ENDP

op_OR PROC USES EAX EBX EDX
	; DESCRIPTION
	; Prompts the user for two 32 bit hexadecimal integers, LOP and ROP.
	; Print the result of (LOP | ROP).

	; print first input prompt
	mov edx,OFFSET firstInputPrompt
	call WriteString
	; read LOP into eax
	call ReadHex
	; copy LOP to ebx
	mov ebx,eax
	
	; print next input prompt
	mov edx,OFFSET nextInputPrompt
	call WriteString
	; read ROP into eax
	call ReadHex

	; calculate result
	OR eax,ebx
	; print result
	mov edx,OFFSET resultStatement
	call WriteString
	call WriteHex
	call Crlf
	call Crlf
	ret
op_OR ENDP

op_XOR PROC USES EAX EBX EDX
	; DESCRIPTION
	; Prompts the user for two 32 bit hexadecimal integers, LOP and ROP.
	; Print the result of (LOP ^ ROP).

	; print first input prompt
	mov edx,OFFSET firstInputPrompt
	call WriteString
	; read LOP into eax
	call ReadHex
	; copy LOP to ebx
	mov ebx,eax
	
	; print next input prompt
	mov edx,OFFSET nextInputPrompt
	call WriteString
	; read ROP into eax
	call ReadHex

	; calculate result
	XOR eax,ebx
	; print result
	mov edx,OFFSET resultStatement
	call WriteString
	call WriteHex
	call Crlf
	call Crlf
	ret
op_XOR ENDP

op_NOT PROC USES EAX EBX EDX
	; DESCRIPTION
	; Prompts the user for a 32 bit hexadecimal integer, LOP.
	; Print the result of (!LOP).

	; print first input prompt
	mov edx,OFFSET firstInputPrompt
	call WriteString
	; read LOP into eax
	call ReadHex

	; calculate result
	NOT eax
	; print result
	mov edx,OFFSET resultStatement
	call WriteString
	call WriteHex
	call Crlf
	call Crlf
	ret
op_NOT ENDP

END main