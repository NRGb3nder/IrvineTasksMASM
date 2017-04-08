.686
.model flat, stdcall
.stack 4096

ExitProcess PROTO :DWORD
DumpRegs PROTO

.data
    	Uarray      DWORD   1000h, 2000h, 3000h, 4000h
    	Sarray      SDWORD  -1, -2, -3, -4

.code

main PROC
    	mov     eax, Uarray
    	mov     ebx, Uarray + 4
    	mov     ecx, Uarray + 8
    	mov     edx, Uarray + 12
    	call    DumpRegs    ; EAX = 1000h, EBX = 2000h, ECX = 3000h, EDX = 4000h

    	mov     eax, Sarray
    	mov     ebx, Sarray + 4
    	mov     ecx, Sarray + 8
    	mov     edx, Sarray + 12
    	call    DumpRegs    ; EAX = 0FFFFFFFFh, EBX = 0FFFFFFFEh, ECX = 0FFFFFFFDh, EDX = 0FFFFFFFCh

    	call    ExitProcess
main ENDP

END main