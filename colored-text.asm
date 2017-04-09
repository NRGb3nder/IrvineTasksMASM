INCLUDE Irvine32.inc

.data
    	specifiedString      BYTE    "This is a colored string!", 0        

.code

main PROC
        mov     edx, OFFSET specifiedString
        mov     eax, white + (blue * 16)
        call    WriteColoredStr
        mov     eax, red + (black * 16)
        call    WriteColoredStr
        mov     eax, lightGreen + (magenta * 16)
        call    WriteColoredStr
        mov     eax, lightMagenta + (lightBlue * 16)
        call    WriteColoredStr
        
        call    CrLf
        mov     eax, white + (black * 16)
        call    SetTextColor
        call    WaitMsg

        invoke  ExitProcess, 0
main ENDP

WriteColoredStr PROC
; RECIEVES: edx: offset of a string to output
;           eax: Irvine's color data
; RETURNS:  -
        call    SetTextColor
        call    WriteString
        call    CrLf

        ret
WriteColoredStr ENDP

END main
