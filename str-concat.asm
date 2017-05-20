INCLUDE Irvine32.inc

.data
        targetString    BYTE    "Copy should be here: ", 5 DUP (0)
        sourceString    BYTE    "COPY", 0

.code

main PROC
        push    OFFSET targetString
        push    OFFSET sourceString
        call    Str_concat
        mov     edx, OFFSET targetString
        call    WriteString
        call    CrLf
        call    CrLf

        call    WaitMsg
        push    0
        call    ExitProcess
main ENDP

Str_concat PROC
        push    ebp
        mov     ebp, esp
        pushad
        mov     edi, [ebp + 12] ; target string
        mov     esi, [ebp + 8]  ; source string

        xor     eax, eax
LScanString:
        scasb
        jne     LScanString
        dec     edi
        mov     ecx, 1
        cld
LConcatStrings:
        inc     ecx
        rep     movsb
        cmp     [esi], eax
        jne     LConcatStrings

LExitStr_concat:
        popad
        pop     ebp
        ret     8
Str_concat ENDP

END main
