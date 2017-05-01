INCLUDE Irvine32.inc

.data
        msgPrompt       BYTE    "Enter value N.", 0
        msgFactorial    BYTE    "N!: ", 0
        msgRepeat       BYTE    "Press SPACE to restart program, any other key to exit.", 0

.code

main PROC
LBegin:
        call    ClrScr
        mov     edx, OFFSET msgPrompt
        call    WriteString
        call    CrLf
        call    ReadDec
        push    eax
        call    Factorial
        call    ClrScr
        mov     edx, OFFSET msgFactorial
        call    WriteString
        call    WriteDec
        call    CrLf
        call    CrLf
        mov     edx, OFFSET msgRepeat
        call    WriteString
        call    ReadChar
        cmp     al, ' '
        je      LBegin
        jmp     LEnd

LEnd:
        push    0
        call    ExitProcess
main ENDP

Factorial PROC
        push    ebp
        mov     ebp, esp
        push    ecx
        mov     ecx, [ebp + 8]

        mov     eax, 1
        or      ecx, ecx
        jz      LExitFactorial
        cmp     ecx, 13
        jb      LCalculateFactorial
        mov     eax, 0
        jmp     LExitFactorial
LCalculateFactorial:
        mul     ecx
        loop    LCalculateFactorial

LExitFactorial:
        pop     ecx
        pop     ebp
        ret     4
Factorial ENDP

END main
