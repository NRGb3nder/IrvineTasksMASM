.686
.model flat, stdcall
.stack 4096

ExitProcess PROTO :DWORD
DumpRegs PROTO

.data
        fibonacciArray      BYTE    1, 1, 5 DUP (?)

.code

main PROC
        xor     eax, eax
        mov     al, fibonacciArray[0]
        call    DumpRegs
        mov     al, fibonacciArray[1]
        call    DumpRegs

        mov     ecx, 5
        mov     bl, fibonacciArray
        mov     dl, fibonacciArray + 1
        mov     esi, 1
NewNum:
        mov     al, bl
        add     al, dl
        mov     fibonacciArray[esi + 1], al
        call    DumpRegs
        mov     bl, fibonacciArray[esi]
        inc     esi 
        mov     dl, fibonacciArray[esi]
        loop    NewNum
        ; eax: 1 -> 1 -> 2 -> 3 -> 5 -> 8 -> 13 
        ; fibonacciArray: 1, 1, 2, 3, 5, 8, 13

	xor     eax, eax
 	invoke  ExitProcess, 0 
main ENDP

END main
