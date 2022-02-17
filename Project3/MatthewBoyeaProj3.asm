COMMENT !
 * TASK 1
 * Precondition: a, b, c, d are all defined integers
 * Postcondition: a = (a + b) - (c + d)
 * TASK 2
 * Precondition: Constants are defined for each day of the week
 * Postcondition: An array is initialized with the constants defined for each day of the week
 * TASK 3
 * Precondition: 
 * Postcondition: Variables of each type avaliable in MASM are initialized with relevant values
 * TASK 4
 * Precondition: Constants are defined as string literals
 * Postcondition: A variable is initialized with each string literal
 * 
 * Author: Matthew Boyea
 * Date: 2022/2/16
 * !

ExitProcess proto

.data
; TASK 1
a dword 255
b dword 255
c dword 255
d dword 255

; TASK 2
SUNDAY EQU 1b
MONDAY EQU 10b
TUESDAY EQU 100b
WEDNESDAY EQU 1000b
THURSDAY EQU 10000b
FRIDAY EQU 100000b
SATURDAY EQU 1000000b

weekArray DWORD SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY

; TASK 3
u8bit byte 255
s8bit sbyte -128
u16bit word 65535
s16bit sword -32768
u32bit dword 4294967295
s32bit sdword -2147483648

farword fword 0FFFFFFFFFFFFh
quadword qword 0FFFFFFFFFFFFFFFFh
tenbyte tbyte 0FFFFFFFFFFFFFFFFFFFFh

float real4 0.0
double real8 0.0
extDouble real10 0.0

; TASK 4
STR_HELLO EQU "Hello, World!"
STR_GOODBYE EQU "Goodbye, World!"

hello db STR_HELLO,0
bye db STR_GOODBYE,0



.code
main proc
	; TASK 1
	mov	eax,a
	mov ebx,b
	mov ecx,c
	mov edx,d

	add eax, ebx	; a is a + b
	add ecx, edx	; c is c + d
	sub	eax, ecx	; a is a - c

	call  ExitProcess
main endp

end
