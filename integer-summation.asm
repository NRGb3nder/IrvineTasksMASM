INCLUDE Irvine32.inc

.data
        arraySize = 5    
        specifiedArray      SDWORD   arraySize DUP(?)
        prompt1             BYTE     "Enter a signed integer value", 0
        prompt2             BYTE     "Sum: ", 0                

.code

main PROC
        mov     esi, OFFSET specifiedArray
        mov     ecx, arraySize
        call    PromptForIntegers
        call    ArraySum
        call    DisplaySum

        invoke  ExitProcess, 0
main ENDP

PromptForIntegers PROC
; RECIEVES: esi: empty sdword array offset
;           ecx: quantity of elements in a sdword array           
; RETURNS:  -
        pushad

        mov     edx, OFFSET prompt1
ReadInteger:
        call    WriteString
        call    CrLf
        call    ReadInt
        mov     [esi], eax
        add     esi, 4
        call    ClrScr
        loop    ReadInteger
        
        popad
        ret      
PromptForIntegers ENDP

ArraySum PROC USES esi ecx
; RECIEVES: esi: sdword array offset
;           ecx: quantity of elements in a sdword array
; RETURNS:  eax: sum of array elements 
        xor     eax, eax

AddElement:
        add     eax, [esi]
        add     esi, 4
        loop    AddElement

        ret  
ArraySum ENDP

DisplaySum PROC USES edx
; RECIEVES: eax: sum of array elements
; RETURNS: -
        mov     edx, OFFSET prompt2
        call    WriteString
        call    WriteInt
        call    CrLf
        call    WaitMsg

        ret
DisplaySum ENDP

END main

