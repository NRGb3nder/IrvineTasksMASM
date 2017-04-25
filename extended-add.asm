INCLUDE Irvine32.inc

.data
        firstOperand    DWORD   0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh
        secondOperand   DWORD   0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh
        sum             DWORD   9 DUP(0)

.code

Testing PROC
        mov     esi, OFFSET firstOperand
        mov     edi, OFFSET secondOperand
        mov     ebx, OFFSET sum
        mov     ecx, 8
        call    ExtendedAdd

        add     ebx, 32
        mov     ecx, 9
Output:
        mov     eax, [ebx]
        call    WriteHex
        sub     ebx, 4
        loop    Output

        call    CrLf
        call    WaitMsg
        invoke  ExitProcess, 0
Testing ENDP

ExtendedAdd PROC
        pushad
        clc

Summation:
        mov     eax, [esi]
        adc     eax, [edi]
        pushfd
        mov     [ebx], eax
        add     esi, 4
        add     edi, 4
        add     ebx, 4
        popfd
        loop    Summation
        mov     DWORD PTR [ebx], 0
        adc     DWORD PTR [ebx], 0

        popad
        ret
ExtendedAdd ENDP

END Testing
