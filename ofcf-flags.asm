.686
.model flat, stdcall
.stack 4096

ExitProcess PROTO :DWORD
DumpRegs PROTO

.data
        firstValue      BYTE    01000000b
        secondValue     BYTE    10000000b
        thirdValue      BYTE    11111111b 

.code

main PROC
        xor     eax, eax
        mov     al, firstValue
        call    DumpRegs    ; OF = 0, CF = 0
        add     al, firstValue
        call    DumpRegs    ; OF = 1, CF = 0

        xor     eax, eax
        mov     al, secondValue
        add     al, 0
        call    DumpRegs    ; OF = 0, CF = 0
        add     al, thirdValue
        call    DumpRegs    ; OF = 1, CF = 1 

        invoke  ExitProcess, 0 
main ENDP

END main
