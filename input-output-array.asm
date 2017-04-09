INCLUDE Irvine32.inc

.data
        arraySize = 10    
        specifiedArray      SDWORD   arraySize DUP(?)
        prompt1             BYTE     "Enter a signed integer value", 0
        prompt2             BYTE     "Array elements: ", 0                

.code

main PROC
        mov     esi, OFFSET specifiedArray
        mov     ecx, arraySize
        call    PromptForIntegers
        call    OutputArray

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

OutputArray PROC USES edx esi
; RECIEVES: esi: filled sdword array offset
; RETURNS:  -
        mov     edx, OFFSET prompt2
        call    WriteString

PrintInteger:
        mov     eax, [esi]
        call    WriteInt
        add     esi, 4
        mov     al, 32
        call    WriteChar
        loop    PrintInteger

        call    CrLf
        call    WaitMsg
        ret
OutputArray ENDP

END main

