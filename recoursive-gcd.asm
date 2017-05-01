INCLUDE Irvine32.inc

.const
        firstValue = 24
        secondValue = 20

.data
        msgResult   BYTE    "GCD: ", 0

.code

main PROC
        push    firstValue
        push    secondValue
        call    GetGCD
        mov     edx, OFFSET msgResult
        call    WriteString
        call    WriteDec
        call    CrLf

        call    CrLf
        call    WaitMsg
        push    0
        call    ExitProcess
main ENDP

GetGCD PROC
        push    ebp
        mov     ebp, esp
        push    ebx
        mov     eax, [esp + 12]
        mov     ebx, [esp + 8]

        cmp     eax, ebx
        je      LExitGetGCD
        jnz     LNextComparison
        mov     eax, ebx
        jmp     LExitGetGCD
LNextComparison:
        cmp     ebx, eax
        jz      LExitGetGCD
        jb      LFirstValueGreater
        sub     ebx, eax
        push    ebx
        push    eax
        call    GetGCD
        jmp     LExitGetGCD
LFirstValueGreater:
        sub     eax, ebx
        push    eax
        push    ebx
        call    GetGCD

LExitGetGCD:
        pop     ebx
        pop     ebp
        ret     8
GetGCD ENDP

END main
