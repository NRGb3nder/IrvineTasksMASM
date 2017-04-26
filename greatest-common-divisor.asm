INCLUDE Irvine32.inc

.data
        firstValue   SDWORD   42
        secondValue  SDWORD   30
        thirdValue   SDWORD   11
        fourthValue  SDWORD   -8

.code

main PROC
        mov     eax, firstValue
        mov     ebx, secondValue
        call    OutputGCD
        mov     ebx, thirdValue
        call    OutputGCD
        mov     eax, fourthValue
        call    OutputGCD
        mov     ebx, firstValue
        call    OutputGCD
        
        call    CrLf
        call    WaitMsg
        invoke  ExitProcess, 0
main ENDP

GetGCD PROC USES eax ebx
        or      eax, eax
        jns     TakeSecondAbsolute
        neg     eax
TakeSecondAbsolute:
        or      ebx, ebx
        jns     CalculateGCD
        neg     ebx
        
CalculateGCD:
        xor     edx, edx
        div     ebx
        mov     eax, ebx
        mov     ebx, edx
        or      edx, edx
        jnz     CalculateGCD
        
        mov     edx, eax
        ret
GetGCD ENDP

OutputGCD PROC USES eax
        call    GetGCD
        mov     eax, edx
        call    WriteDec
        mov     eax, ' '
        call    WriteChar

        ret
OutputGCD ENDP

END main
