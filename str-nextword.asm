INCLUDE Irvine32.inc

.data
        targetString    BYTE    "Johnson, Kelvin", 0
        msgOrigin       BYTE    "ORIGIN: ", 0
        msgResult       BYTE    "RESULT: ", 0

.code

main PROC
        lea     edx, msgOrigin
        call    WriteString
        lea     edx, targetString
        call    WriteString
        call    CrLf
        push    edx
        push    ','
        call    Str_nextword
        lea     edx, msgResult
        call    WriteString
        lea     edx, targetString
        call    WriteString

        call    CrLf
        call    CrLf
        call    WaitMsg
        push    0
        call    ExitProcess
main ENDP

Str_nextword PROC
        push    ebp
        mov     ebp, esp
        push    edi
        push    ebx
        mov     edi, [ebp + 12] ; target string
        mov     ebx, [ebp + 8]  ; separator

        push    edi
        call    Str_length
        mov     ecx, eax
LNextChar:
        mov     al, BYTE PTR [edi]
        xor     eax, ebx
        jz      LGetResult
        inc     edi
        loop    LNextChar
LGetResult:
        and     eax, eax       ; ZF = 0
        jnz     LExitStr_nextword
        stosb
        inc     edi
        mov     eax, edi
        xor     ebx, ebx       ; ZF = 1

LExitStr_nextword:
        pop     ebx
        pop     edi
        pop     ebp
        ret     8
Str_nextword ENDP

END main
