INCLUDE Irvine32.inc

.data
        firstOperand    DWORD   0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh
        secondOperand   DWORD   0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh
        sum             DWORD   9 DUP(0)

.code

Testing PROC
        mov     esi, OFFSET firstOperand + SIZEOF firstOperand - TYPE firstOperand
        mov     edi, OFFSET secondOperand + SIZEOF secondOperand - TYPE secondOperand
        mov     ebx, OFFSET sum + SIZEOF sum - TYPE sum
        mov     ecx, 8
        call    ExtendedAdd

        mov     ecx, 9
        mov     ebx, OFFSET sum
Output:
        mov     eax, [ebx]
        call    WriteHex
        mov     eax, ' '
        call    WriteChar
        add     ebx, TYPE sum
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
        sub     esi, 4
        sub     edi, 4
        sub     ebx, 4
        popfd
        loop    Summation
        mov     DWORD PTR [ebx], 0
        adc     DWORD PTR [ebx], 0

        popad
        ret
ExtendedAdd ENDP

END Testing
