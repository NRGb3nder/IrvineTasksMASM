INCLUDE Irvine32.inc

.const
        arrayLength = 50
        dwordSize = 4
        randomLimit = 41
        randomCorrector = 20

.data 
        randomArray     DWORD    arrayLength DUP (?)
        msgArray        BYTE     "Array elements: ", 0

.code

main PROC
        mov     esi, OFFSET randomArray
        mov     ecx, arrayLength

AddElement:
        call    NewRandomToArray
        mov     [esi], eax       ; random value -20..+20
        add     esi, dwordSize
        loop    AddElement

        mov     esi, OFFSET randomArray
        mov     ebx, LENGTHOF randomArray
        call    OutputArray

        invoke  ExitProcess, 0
main ENDP

NewRandomToArray PROC
; RECIEVES: -
; RETURNS:  eax: random value
        mov     eax, randomLimit
        call    RandomRange
        sub     eax, randomCorrector
        
        ret
NewRandomToArray ENDP

OutputArray PROC
; REVIECES: esi: array offset
;           ebx: quantity of array elements
; RETURNS:  -
        pushad

        mov     ecx, ebx
        mov     edx, OFFSET msgArray
        call    WriteString
         
OutputElem:
        mov     eax, [esi]
        call    WriteInt
        mov     eax, ' '
        call    WriteChar
        add     esi, dwordSize
        loop    OutputElem

        call    CrLf
        call    WaitMsg

        popad
        ret
OutputArray ENDP

END main

