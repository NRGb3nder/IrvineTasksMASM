INCLUDE Irvine32.inc

.const
        stringLength = 10
        stringsQuantity = 20
        randomLimit = 25
        randomCorrector = 65

.data 
        randomString     BYTE    stringLength DUP (?)

.code

main PROC
        mov     esi, OFFSET randomString
        mov     edi, stringsQuantity

AddString:
        mov     ecx, stringLength
AddChar:
        call    NewRandomChar
        mov     [esi], eax       ; random char A-Z
        inc     esi
        loop    AddChar

        mov     esi, OFFSET randomString
        call    OutputString
        call    CrLf
        dec     edi
        jnz     AddString

        call    WaitMsg
        invoke  ExitProcess, 0
main ENDP

NewRandomChar PROC
; RECIEVES: -
; RETURNS:  eax: random char
        xor     eax, eax 
        mov     eax, randomLimit
        call    RandomRange
        add     eax, randomCorrector
        
        ret
NewRandomChar ENDP

OutputString PROC
; REVIECES: esi: string offset
; RETURNS:  -
        pushad
        mov     ecx, stringLength
       
OutputChar:
        mov     eax, [esi]
        call    WriteChar
        inc     esi
        loop    OutputChar

        popad
        ret
OutputString ENDP

END main

