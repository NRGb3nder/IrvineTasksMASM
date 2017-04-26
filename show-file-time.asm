INCLUDE Irvine32.inc

.data
        packedTime      WORD    0001001000000111b

.code

main PROC
        mov     ax, packedTime
        call    ShowFileTime 

        call    CrLf
        call    WaitMsg
        invoke  ExitProcess, 0
main ENDP

ShowFileTime PROC USES ax bx
.const
        MASK_REGISTER_FORMAT = 00000000000000001111111111111111b
        MASK_MINUTES = 0000000000111111b
        MASK_SECONDS = 0000000000011111b
        SHIFT_HOURS = 11
        SHIFT_MINUTES = 5

.code
        and     eax, MASK_REGISTER_FORMAT
        mov     bx, ax
        shr     ax, SHIFT_HOURS
        cmp     ax, 10
        jge     OutputHours
        call    OutputZero
OutputHours:
        call    WriteDec
        call    OutputColon

        mov     ax, bx
        shr     ax, SHIFT_MINUTES
        and     ax, MASK_MINUTES
        cmp     ax, 10
        jge     OutputMinutes
        call    OutputZero
OutputMinutes:
        call    WriteDec
        call    OutputColon

        mov     ax, bx
        and     ax, MASK_SECONDS
        cmp     ax, 10
        jge     OutputSeconds
        call    OutputZero
OutputSeconds:
        call    WriteDec
        
        ret
ShowFileTime ENDP

OutputZero PROC USES eax
        mov     eax, '0'
        call    WriteChar

        ret
OutputZero ENDP

OutputColon PROC USES eax
        mov     eax, ':'
        call    WriteChar

        ret
OutputColon ENDP

END main
