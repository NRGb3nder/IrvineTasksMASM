INCLUDE Irvine32.inc

.data
        firstOperand    SDWORD      0
        secondOperand   SDWORD      10
        thirdOperand    SDWORD      11

.code

main PROC
        xor     eax, eax            ; X
        mov     ebx, firstOperand   ; op1
        mov     ecx, secondOperand  ; op2
        mov     edx, thirdOperand   ; op3

        .WHILE (ebx < ecx)
            inc     ebx
            .IF (ecx == edx)
                mov     al, 2
            .ELSE
                mov     al, 3
            .ENDIF
        .ENDW

        call    WriteInt
        call    CrLf
        call    WaitMsg
        invoke  ExitProcess, 0
main ENDP

END main
