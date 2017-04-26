INCLUDE Irvine32.inc

.data
        firstOperand    DWORD   0FFFFFFFFh, 0FFFFFFFEh
        secondOperand   DWORD   0FFFFFFFEh, 0FFFFFFFFh
        result          DWORD   3 DUP(0)

.code

Testing PROC
        mov     esi, OFFSET firstOperand + SIZEOF firstOperand - TYPE firstOperand
        mov     edi, OFFSET secondOperand + SIZEOF secondOperand - TYPE secondOperand
        mov     ebx, OFFSET result + SIZEOF result - TYPE result
        mov     ecx, 2
        call    ExtendedSub

        mov     ecx, 3
        mov     ebx, OFFSET result
Output:
        mov     eax, [ebx]
        call    WriteHex
        mov     eax, ' '
        call    WriteChar
        add     ebx, TYPE result
        loop    Output

        call    CrLf
        call    WaitMsg
        invoke  ExitProcess, 0
Testing ENDP

ExtendedSub PROC
        pushad
        clc

Subtraction:
        mov     eax, [esi]
        sbb     eax, [edi]
        pushfd
        mov     [ebx], eax
        sub     esi, 4
        sub     edi, 4
        sub     ebx, 4
        popfd
        loop    Subtraction
        mov     DWORD PTR [ebx], 0
        adc     DWORD PTR [ebx], 0

        popad
        ret
ExtendedSub ENDP

END Testing
