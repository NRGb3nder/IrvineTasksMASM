INCLUDE Irvine32.inc

.data
        firstArray      BYTE    0FFh, 0FEh, 0FDh, 0FCh, 0FBh, 0FAh
        secondArray     WORD    0ABCDh, 0DCBAh, 0CDEFh, 0FEDCh

.code

main PROC
        push    TYPE firstArray
        push    LENGTHOF firstArray
        push    OFFSET firstArray
        call    DumpMemory

        push    TYPE secondArray
        push    LENGTHOF secondArray
        push    OFFSET secondArray
        call    DumpMemory

        call    CrLf
        call    WaitMsg
        push    0
        call    ExitProcess
main ENDP

DumpMemory PROC
        push    ebp
        mov     ebp, esp
        pushad
        mov     ebx, [ebp + 16]
        mov     ecx, [ebp + 12]
        mov     esi, [ebp + 8]

LOutputElement:
        mov     eax, [esi]
        call    WriteHexB
        mov     eax, ' '
        call    WriteChar
        add     esi, ebx
        loop    LOutputElement
        call    CrLf

        popad
        pop     ebp
        ret     12
DumpMemory ENDP

END main
