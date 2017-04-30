INCLUDE Irvine32.inc

.data
        generatedArray  DWORD   20 DUP(?)

.code

main PROC
        push    OFFSET generatedArray
        call    InitArray
        push    OFFSET generatedArray
        push    LENGTHOF generatedArray
        call    OutputArray
        call    DoExchange

        call    WaitMsg
        push    0
        call    ExitProcess
main ENDP

DoExchange PROC
        pushad

        mov     esi, OFFSET generatedArray
        xor     eax, eax
        mov     ebx, OFFSET generatedArray
        add     ebx, SIZEOF generatedArray - TYPE generatedArray
LExchangeElements:
        push    esi
        add     esi, 4
        push    esi
        call    Swap
        add     esi, 4
        cmp     esi, ebx
        jb      LExchangeElements
        push    OFFSET generatedArray
        push    LENGTHOF generatedArray
        call    OutputArray

        popad
        ret     0
DoExchange ENDP

InitArray PROC
        call    Randomize
        push    ebp
        mov     ebp, esp
        pushad
        mov     esi, [ebp + 8]

        mov     ecx, 20
LGenerateElement:
        mov     eax, 100
        call    RandomRange
        mov     [esi], eax
        add     esi, 4
        loop    LGenerateElement

        popad
        pop     ebp
        ret     4
InitArray ENDP

Swap PROC
        push    ebp
        mov     ebp, esp
        push    eax
        push    esi
        push    edi
        mov     esi, [ebp + 12]
        mov     edi, [ebp + 8]

        mov     eax, [esi]
        xchg    eax, [edi]
        mov     [esi], eax

        pop     edi
        pop     esi
        pop     eax
        pop     ebp
        ret     8
Swap ENDP

OutputArray PROC
        push    ebp
        mov     ebp, esp
        pushad

        mov     esi, [ebp + 12]
        mov     ecx, [ebp + 8]
LOutputElement:
        mov     eax, [esi]
        call    WriteDec
        mov     eax, ' '
        call    WriteChar
        add     esi, 4
        loop    LOutputElement
        call    CrLf

        popad
        pop     ebp
        ret     8
OutputArray ENDP

END main
