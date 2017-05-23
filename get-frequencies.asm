INCLUDE Irvine32.inc

.data
        TABLE_SIZE = 256
        target      BYTE    "AAEBDCFBBC", 0
        freqTable   BYTE    TABLE_SIZE DUP(0)
        msgOrigin   BYTE    "STRING: ", 0
        msgTable    BYTE    "FREQ TABLE: ", 0

.code

main PROC
        lea     edx, msgOrigin
        call    WriteString
        lea     edx, target
        call    WriteString
        call    CrLf
        lea     edx, msgTable
        call    WriteString
        call    CrLf
        push    OFFSET freqTable
        push    OFFSET target
        call    Get_frequencies
        lea     esi, freqTable
        mov     ecx, LENGTHOF freqTable
        xor     ebx, ebx
LNextTablePos:
        mov     eax, ebx
        inc     ebx
        call    WriteDec
        call    WriteSpace
        mov     al, [esi]
        call    WriteDec
        call    CrLf
        inc     esi
        loop    LNextTablePos

        call    CrLf
        call    CrLf
        call    WaitMsg
        push    0
        call    ExitProcess
main ENDP

WriteSpace PROC
        mov     al, ' '
        call    WriteChar

        ret
WriteSpace ENDP

Get_frequencies PROC
        push    ebp
        mov     ebp, esp
        pushad
        mov     esi, [ebp + 12] ; frequency table
        mov     edi, [ebp + 8]  ; target string

        push    edi
        call    Str_length
        mov     ecx, eax
        xor     eax, eax
LNextChar:
        push    esi
        mov     al, [edi]
        add     esi, eax
        mov     bl, [esi]
        inc     bl
        mov     [esi], bl
        pop     esi
        inc     edi
        loop    LNextChar

        popad
        pop     ebp
        ret     8
Get_frequencies ENDP

END main
