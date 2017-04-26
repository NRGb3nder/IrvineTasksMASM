INCLUDE Irvine32.inc

.data
        firstOperand    DWORD   113
        secondOperand   DWORD   12

.code

Testing PROC
        mov     eax, firstOperand
        mov     ebx, secondOperand
        call    FastMultiply
        call    WriteDec

        call    CrLf
        call    WaitMsg
        invoke  ExitProcess, 0
Testing ENDP

FastMultiply PROC USES ebx ecx edx
        xor     edx, edx
        mov     ecx, 32
GetSummand:
        sal     ebx, 1
        jnc     NextIteration
        push    eax
        push    ecx
        dec     ecx
        shl     eax, cl
        add     edx, eax
        pop     ecx
        pop     eax
NextIteration:
        loop    GetSummand   

        mov     eax, edx
        ret
FastMultiply ENDP

END Testing
