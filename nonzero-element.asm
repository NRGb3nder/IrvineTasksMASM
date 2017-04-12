INCLUDE Irvine32.inc

.data
        intArray    SDWORD      0, 0, 0, 0, 1, 20, 35, -12, 66, 4, 0
        noneMsg     BYTE        "Nonzero element not found", 0

.code

main PROC
        mov     ebx, OFFSET intArray - TYPE intArray
        mov     ecx, LENGTHOF intArray

NextElement:
        add     ebx, TYPE intArray
        cmp     SDWORD PTR [ebx], 0
        loopz   NextElement
        jz      NotFound

        xor     eax, eax
        mov     eax, SDWORD PTR [ebx]
        call    WriteInt 
        jmp     Quit

NotFound:
        mov     edx, OFFSET noneMsg
        call    WriteString

Quit:
        call    CrLf
        call    WaitMsg
        invoke  ExitProcess, 0
main ENDP

END main