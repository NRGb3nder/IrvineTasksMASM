INCLUDE Irvine32.inc

.const
        valueN = 10
        repeatTimes = 500000

.data
        msgFirstTestTime    BYTE    "Recoursive algorithm time (mseconds): ", 0
        msgSecondTestTime   BYTE    "Loop algorithm time (mseconds):      ", 0

.code

main PROC
        call    GetMseconds
        mov     ebx, eax
        mov     ecx, repeatTimes
LFirstTest:
        push    valueN
        call    RecoursiveFactorial
        loop    LFirstTest
        call    GetMseconds
        sub     eax, ebx
        mov     edx, OFFSET msgFirstTestTime
        call    WriteString
        call    WriteDec
        call    CrLf

        call    GetMseconds
        mov     ebx, eax
        mov     ecx, repeatTimes
LSecondTest:
        push    valueN
        call    LoopFactorial
        loop    LSecondTest
        call    GetMseconds
        sub     eax, ebx
        mov     edx, OFFSET msgSecondTestTime
        call    WriteString
        call    WriteDec
        call    CrLf

LEnd:
        call    CrLf
        call    WaitMsg
        push    0
        call    ExitProcess
main ENDP

RecoursiveFactorial PROC
        push    ebp
        mov     ebp, esp
        push    ebx

        mov     eax, [ebp + 8]
        or      eax, eax
        ja      LContinueCalculations
        mov     eax, 1
        jmp     LExitRecoursiveFactorial
LContinueCalculations:
        dec     eax
        push    eax
        call    RecoursiveFactorial
LReturnFactorial:
        mov     ebx, [ebp + 8]
        mul     ebx

LExitRecoursiveFactorial:
        pop     ebx
        pop     ebp
        ret     4
RecoursiveFactorial ENDP

LoopFactorial PROC
        push    ebp
        mov     ebp, esp
        push    ecx
        mov     ecx, [ebp + 8]

        mov     eax, 1
        cmp     eax, 0
        jbe     LExitLoopFactorial
        cmp     ecx, 13
        jb      LCalculateFactorial
        mov     eax, 0
        jmp     LExitLoopFactorial
LCalculateFactorial:
        mul     ecx
        loop    LCalculateFactorial

LExitLoopFactorial:
        pop     ecx
        pop     ebp
        ret     4
LoopFactorial ENDP

END main
