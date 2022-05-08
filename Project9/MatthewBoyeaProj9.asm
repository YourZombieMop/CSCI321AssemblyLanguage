TITLE Project 6
; DESCRIPTION
; Request a string to search for (source) and a string to search within (destination) from the user.
; Return the first matching occurrance of a source string inside a target string.
; Author: Matthew Boyea
; Date: 2022-5-02

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

INCLUDE Irvine32.inc

STRING typedef BYTE
ADDRESS typedef DWORD
INTEGER typedef DWORD

.data
Str_find PROTO src:PTR STRING, dest:PTR STRING

INPUT_SIZE equ 3
srcInput STRING INPUT_SIZE DUP(?),0
destInput STRING INPUT_SIZE DUP(?),0

srcPrompt STRING "Enter the string to search for (source): ",0
destPrompt STRING "Enter the string to search within (destination): ",0
succMessage STRING "The source string was found in the destination string at character ",0
failMessage STRING "The source string was not found in the destination string",0
quitPrompt STRING "Press any key to quit...",0

.code
main PROC
	; get srcInput
	mov edx,OFFSET srcPrompt ; write prompt
	call WriteString
	mov edx,OFFSET srcInput ; read input
	mov ecx,(INPUT_SIZE + 1)
	call ReadString

	; get destInput
	mov edx,OFFSET destPrompt ; write prompt
	call WriteString
	mov edx,OFFSET destInput ; read input
	mov ecx,(INPUT_SIZE + 1)
	call ReadString

	; search for srcInput within destInput
	invoke Str_find,ADDR srcInput,ADDR destInput
	jnz FIND_STR_FAILED
FIND_STR_FOUND: ; string found
	mov edx,OFFSET succMessage
	call WriteString
	call WriteDec
	call Crlf
	jmp FIND_STR_END
FIND_STR_FAILED: ; string not found
	mov edx,OFFSET failMessage
	call WriteString
	call Crlf
FIND_STR_END:

	; exit program
	call Crlf ; wait for input
	mov edx,OFFSET quitPrompt
	call WriteString
	call ReadChar
	invoke ExitProcess,0 ; exit
main ENDP

Str_find PROC USES esi edi ebx edx ecx src:PTR STRING, dest:PTR STRING
	; RECEIVES
	; src: address of string to find
	; dest: address of string to search within
	; RETURNS
	; zf: true if src is found within dest; otherwise false
	; eax: address of the string found within DEST that contains the same data as SRC

	; I have been unable to get this function working. I have stepped through the code and tried to debug it, but I really don't know what's going wrong here. I understand it's a hacked-together solution, but the cmpsb instruction doesn't even seem to compare the values properly. I'm not sure what to do. I'll turn in the assignment as-is.

	mov esi,src   ; set srcCharacter
	mov edi,dest  ; set destCharacter
	mov edx,edi   ; copy destCharacter

	jmp STR_CMP   ; begin loop
STR_CMP_NEXT_DEST:
	mov esi,src   ; reset srcCharacter
	mov edi,edx   ; restore copy of destCharacter
	inc edx       ; increment copy of destCharacter
	cmp STRING PTR [edx],0  ; if (copy of destCharacter == null)
	je FIND_STR_FAILED      ;  src does not occur in dest
STR_CMP_NEXT_DEST_NOCOPY:
	inc edi       ; increment destCharacter
STR_CMP:
	cmp STRING PTR [edi],0        ; if (destCharacter == null)
	je FIND_STR_FAILED            ;  src does not occur in dest
	cmpsb                         ; if (destCharacter != srcCharacter)
	dec esi
	dec edi
	jne STR_CMP_NEXT_DEST         ;  continue searching from the next destCharacter
	inc esi                       ; increment srcCharacter
	cmp STRING PTR [esi],0        ; if (srcCharacter == null)
	je FIND_STR_FOUND             ;  src occurs in list at copy of destCharacter
	jmp STR_CMP_NEXT_DEST_NOCOPY  ; continue searching from next destCharacter without updating copy


FIND_STR_FAILED:
	cmp esi,0 ; zf = 0
	jmp FIND_STR_END
FIND_STR_FOUND:
	xor eax,eax ; zf = 1
FIND_STR_END:
	ret
Str_find ENDP

END main