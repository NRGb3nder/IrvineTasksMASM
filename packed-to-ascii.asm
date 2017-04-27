INCLUDE Irvine32.inc

.data
        firstPacked     DWORD   32956543h
        secondPacked    DWORD   12345678h
        thirdpacked     DWORD   98765432h
        asciiBuffer     BYTE    64 DUP(?)

.code

main PROC
        mov     eax, firstPacked
        call    OutputPackedAsAsc
        mov     eax, secondPacked
        call    OutputPackedAsAsc
        mov     eax, thirdPacked
        call    OutputPackedAsAsc

        call    CrLf
        call    WaitMsg
        invoke  ExitProcess, 0
main ENDP

OutputPackedAsAsc PROC USES esi edx
        mov     esi, OFFSET asciiBuffer
        call    PackedToAsc
        mov     edx, OFFSET asciiBuffer
        call    WriteString
        call    CrLf

        ret
OutputPackedAsAsc ENDP

PackedToAsc PROC USES eax ebx
        xor     ebx, ebx
        mov     bx, ax
        shr     eax, 16
        call    Packed16ToUnpacked32
        call    ReverseUnpacked32
        xchg    eax, ebx
        call    Packed16ToUnpacked32
        call    ReverseUnpacked32
        add     eax, 30303030h  ; Unpacked to ASCII
        add     ebx, 30303030h  ; Unpacked to ASCII
        mov     [esi], ebx
        add     esi, 4
        mov     [esi], eax
        
        ret
PackedToAsc ENDP

Packed16ToUnpacked32 PROC   ; 0000XXXXh (eax) to 0X0X0X0Xh (eax)
        ror     eax, 4
        shl     ax, 4
        ror     eax, 8
        shl     ax, 4
        ror     eax, 4
        
        ror     ax, 4
        shl     al, 4
        ror     ax, 4
        
        ror     ax, 8
        ror     eax, 16

        ret
Packed16ToUnpacked32 ENDP

ReverseUnpacked32 PROC
        ror     ax, 8
        ror     eax, 16
        ror     ax, 8

        ret
ReverseUnpacked32 ENDP

END main
