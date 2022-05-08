TITLE Review 3
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

.code
main PROC

	; exit
	invoke ExitProcess,0
main ENDP

END main