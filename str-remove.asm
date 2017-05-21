INCLUDE Irvine32.inc

.data
        targetString    BYTE    "abcxxxxdefghijklmnop", 0
        msgOrigin       BYTE    "ORIGIN: ", 0
        msgResult       BYTE    "RESULT: ", 0

.code

main PROC
        mov     edx, OFFSET msgOrigin
        call    WriteString
        mov     edx, OFFSET targetString
        call    WriteString
        call    CrLf
        push    OFFSET targetString + 3
        push    4
        call    Str_remove
        mov     edx, OFFSET msgResult
        call    WriteString
        mov     edx, OFFSET targetString
        call    WriteString
        call    CrLf
        call    CrLf

        call    WaitMsg
        push    0
        call    ExitProcess
main ENDP

Str_remove PROC
        push    ebp
        mov     ebp, esp
        pushad
        mov     esi, [ebp + 12] ; quantity of chars to delete
        mov     edi, [ebp + 8]  ; target string

        push    esi
        call    Str_length
        add     edi, esi
        push    eax
        push    edi
        push    esi
        call    Str_copyN
        xor     eax, eax
        lodsb

        popad
        pop     ebp
        ret     8
Str_remove ENDP

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

Str_copyN PROC
        push    ebp
        mov     ebp, esp
        pushad
        mov     ebx, [ebp + 16] ; char limit
        mov     esi, [ebp + 12] ; source
        mov     edi, [ebp + 8]  ; target

        push    esi
        call    Str_length
        mov     ecx, eax
        dec     ebx
        cmp     ecx, ebx
        jbe     LContinueCopy
        mov     ecx, ebx
LContinueCopy:
        inc     ecx
        cld
        rep     movsb

        popad
        pop     ebp
        ret     12
Str_copyN ENDP

END main
