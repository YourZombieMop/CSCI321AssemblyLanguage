TITLE Project 5
; DESCRIPTION
; Print 20 random strings with 10 characters each, seperated by newlines. 
; Author: Matthew Boyea
; Date: 2022-3-10

INCLUDE Irvine32.inc

string typedef byte

.data
STR_COUNT equ 20
STR_SIZE equ 10
outputString string STR_SIZE DUP(?),0
prompt string "Press any key to quit...",0

.code
Main PROC
	; prepare for GenerateRandomString
	call Randomize
	mov eax,STR_SIZE
	mov edx,OFFSET outputString

	; loop STR_COUNT times
	mov ecx,STR_COUNT
top:
	call GenerateRandomString
	call WriteString
	call Crlf
	loop top

	; wait for input
	call Crlf
	mov edx,OFFSET prompt
	call WriteString
	call ReadChar
	; exit program
	exit
Main ENDP

GenerateRandomString PROC USES eax ecx
	; RECEIVES
	; eax: length of string LEN
	; edx: destination address of string DEST
	; RETURNS
	; nothing
	; DESCRIPTION
	; Fill a string at DEST of length LEN with random valid characters.
	; It generates ASCII characters within [' ','~'] or [32,126].
	; PRECONDITION
	; Randomize PROC has been called

	; loop LEN times
	mov ecx,eax
top:
	; put a random number within the range of valid ASCII chars in al
	mov eax,('~' - ' ' + 1)
	call RandomRange
	; add the first valid character to make the output range between
	; the first and last valid characters
	add eax,' '
	; copy al to this iteration's character
	mov [edx + ecx - 1],al
	loop top

	; return
	ret
GenerateRandomString ENDP

END main