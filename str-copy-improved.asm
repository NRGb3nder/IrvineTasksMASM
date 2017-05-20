INCLUDE Irvine32.inc

.data
        specifiedString   BYTE    "A string to test str_copy procedure", 0
        stringCopy        BYTE    LENGTHOF specifiedString DUP (' ')
        msgOrigin         BYTE    "STRING: ", 0
        msgCopy           BYTE    "COPY:   ", 0
        msgPartialCopy    BYTE    "COPY2:  ", 0

.code

main PROC
        push    40
        push    OFFSET specifiedString
        push    OFFSET stringCopy
        call    Str_copyN
        call    OutputOrigin
        mov     edx, OFFSET msgCopy
        call    WriteString
        mov     edx, OFFSET stringCopy
        call    WriteString
        call    CrLf
        call    CrLf

        mov     al, ' '
        mov     ecx, LENGTHOF specifiedString - 1
        mov     edi, OFFSET stringCopy
        rep     stosb

        push    10
        push    OFFSET specifiedString
        push    OFFSET stringCopy
        call    Str_copyN
        call    OutputOrigin
        mov     edx, OFFSET msgPartialCopy
        call    WriteString
        mov     edx, OFFSET stringCopy
        call    WriteString
        call    CrLf
        call    CrLf

        call    WaitMsg
        push    0
        call    ExitProcess
main ENDP

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

OutputOrigin PROC
        mov     edx, OFFSET msgOrigin
        call    WriteString
        mov     edx, OFFSET specifiedString
        call    WriteString
        call    CrLf

        ret
OutputOrigin ENDP

END main
