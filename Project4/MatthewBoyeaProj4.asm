COMMENT !
 * DESCRIPTION
 * This program copies a string from source to target, but reversed.
 * 
 * Author: Matthew Boyea
 * Date: 2022/3/4
 * !

ExitProcess proto

string typedef byte

.data
source string "This is the string that will be reversed",0
target string (SIZEOF source) DUP('#')

.code
main proc
	; esi = source char address
	mov esi,OFFSET source
	; edi = target char address
	mov edi,OFFSET target
	add edi,(LENGTHOF source - 2)

	; for every char in source, excluding null char\
	mov ecx,(LENGTHOF source - 1)
LOOP1:
	; copy source char (esi) to target char (edi)
	mov al,[esi]
	mov [edi],al

	; loop-1
	inc esi
	dec edi
	loop LOOP1

	; add null char to target
	mov target[LENGTHOF target - 1],0

	call  ExitProcess
main endp

end
