INCLUDE Irvine32.inc

.const
        MATRIX_SIZE = 16
        SYMBOL_TO_OUTPUT = '@'

.data
        firstColor      BYTE        ?
        secondColor     BYTE        ?

.code

main PROC
        xor     edx, edx

NewRow:
        xor     dl, dl
        inc     dh
NewCol:
        call    WriteColoredSymbol
        inc     dl
        cmp     dl, MATRIX_SIZE
        jne     NewCol
        call    CrLf
        cmp     dh, MATRIX_SIZE
        jne     NewRow
        
        call    CrLf
        call    WaitMsg
          
        invoke  ExitProcess, 0
main ENDP

WriteColoredSymbol PROC
; RECIEVES: -
; RETURNS:  -
        pushad

        mov     firstColor, dl
        mov     secondColor, dh
        xor     eax, eax
        mov     al, secondColor
        mov     bl, 16
        mul     bl 
        add     al, firstColor
        call    SetTextColor
        mov     eax, SYMBOL_TO_OUTPUT
        call    WriteChar

        popad
        ret
WriteColoredSymbol ENDP

END main