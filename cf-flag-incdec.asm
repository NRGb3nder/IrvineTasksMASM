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
	dec     al
	call    DumpRegs    ; CF = 0

	mov     al, specifiedValue
	inc     al
	call    DumpRegs    ; CF = 0

	invoke  ExitProcess, 0 
main ENDP

END main
