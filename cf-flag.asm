.686
.model flat, stdcall
.stack 4096

ExitProcess PROTO :DWORD
DumpRegs PROTO

.data
    specifiedValue      BYTE    11111111b

.code

main PROC
	xor	eax, eax
	call    DumpRegs    ; CF = 0
	sub     al, 1
	call    DumpRegs    ; CF = 1

	add     al, 0
	call    DumpRegs    ; CF = 0
	mov     al, specifiedValue
	add     al, 1 
	call    DumpRegs    ; CF = 1

	xor	eax, eax
	invoke  ExitProcess, 0 
main ENDP

END main
