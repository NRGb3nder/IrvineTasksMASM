INCLUDE Irvine32.inc

.data
    	specifiedString     BYTE    "This is a string to reverse.", 0
        stringSize = ($ - specifiedString) - 1    

.code

main PROC
        mov     ecx, stringSize
        mov     esi, 0
PushChar:
        movzx   eax, specifiedString[esi]
        push    eax
        inc     esi
        loop    PushChar
        
        mov     ecx, stringSize
        mov     esi, 0
PopChar:
        pop     eax
        mov     specifiedString[esi], al
        inc     esi
        loop    PopChar
        
        mov     edx, OFFSET specifiedString
        call    WriteString
        call    CrLf
 	    invoke  ExitProcess, 0 
main ENDP

END main
