.686
.model flat, stdcall
.stack 4096

ExitProcess PROTO :DWORD
DumpRegs PROTO

.data
        specifiedValue      BYTE    10000000b

.code

main PROC
        xor	    eax, eax
        call    DumpRegs    ; ZF = 1
        inc     al
        call    DumpRegs    ; ZF = 0

        xor	    al, al
        call    DumpRegs    ; SF = 0
        add     al, specifiedValue
        call    DumpRegs    ; SF = 1

        invoke  ExitProcess, 0 
main ENDP

END main
