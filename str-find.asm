INCLUDE Irvine32.inc

.data
        targetString         BYTE    "123ABC123321123", 0
        firstSourceString    BYTE    "ABC", 0
        secondSourceString   BYTE    "CBAABC", 0
        position             BYTE    ?
        msgOrigin            BYTE    "ORIGIN:      ", 0
        msgStrToFind         BYTE    "STR TO FIND: ", 0
        msgPosition          BYTE    "STR POS:     ", 0
        msgNotFound          BYTE    "String not found.", 0

.code

main PROC
        call    OutputOrigin
        mov     edx, OFFSET msgStrToFind
        call    WriteString
        mov     edx, OFFSET firstSourceString
        call    WriteString
        call    CrLf
        push    OFFSET targetString
        push    OFFSET firstSourceString
        call    Str_find
        jnz     LFirstNotFound
        call    OutputResult
        jmp     LNextSearch
LFirstNotFound:
        mov     edx, OFFSET msgNotFound
        call    WriteString
LNextSearch:
        call    CrLf
        call    CrLf
        call    OutputOrigin
        mov     edx, OFFSET msgStrToFind
        call    WriteString
        mov     edx, OFFSET secondSourceString
        call    WriteString
        call    CrLf
        push    OFFSET targetString
        push    OFFSET secondSourceString
        call    Str_find
        jnz     LSecondNotFound
        call    OutputResult
        jmp     LExit
LSecondNotFound:
        mov     edx, OFFSET msgNotFound
        call    WriteString

LExit:
        call    CrLf
        call    CrLf
        call    WaitMsg
        push    0
        call    ExitProcess
main ENDP

OutputOrigin PROC
        mov     edx, OFFSET msgOrigin
        call    WriteString
        mov     edx, OFFSET targetString
        call    WriteString
        call    CrLf

        ret
OutputOrigin ENDP

OutputResult PROC
        mov     edx, OFFSET msgPosition
        call    WriteString
        mov     position, al
        call    WriteInt

        ret
OutputResult ENDP

Str_find PROC
        push    ebp
        mov     ebp, esp
        push    esi
        push    edi
        push    ecx
        mov     edi, [ebp + 12] ; target string
        mov     esi, [ebp + 8]  ; source string

        push    edi
        call    Str_length
        mov     ecx, eax
LNextTargetChar:
        push    edi
        push    esi
        call    CheckIfStringFits
        jz      LGetResult
        inc     edi
        loop    LNextTargetChar
LGetResult:
        jnz     LExitStr_find
        sub     eax, ecx
        inc     eax
        xor     ecx, ecx        ; ZF = 1

LExitStr_find:
        pop     ecx
        pop     edi
        pop     esi
        pop     ebp
        ret     8
Str_find ENDP

CheckIfStringFits PROC
        push    ebp
        mov     ebp, esp
        pushad
        mov     edi, [ebp + 12] ; target string
        mov     esi, [ebp + 8]  ; source string

        push    esi
        call    Str_length
        mov     ecx, eax        ; ZF = 0
LNextSourceChar:
        mov     al, [esi]
        mov     bl, [edi]
        cmp     al, bl
        jne     LExitCheckIfStringFits
        inc     esi
        inc     edi
        loop    LNextSourceChar
        xor     eax, eax        ; ZF = 1

LExitCheckIfStringFits:
        popad
        pop     ebp
        ret     8
CheckIfStringFits ENDP

END main
