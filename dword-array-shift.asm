INCLUDE Irvine32.inc

.data
        specifiedArray  DWORD   5 DUP (0FACD5432h)
        ; FACD5432 (hex) = 1111 1010 1100 1101 0101 0100 0011 0010 (bin)

.code

Testing PROC
        mov     eax, OFFSET specifiedArray
        call    ShiftArray

        mov     ecx, 5
        mov     edx, OFFSET specifiedArray
OutputDoubleWord:
        mov     eax, [edx]
        call    WriteBin
        mov     eax, ' '
        call    WriteChar
        add     edx, 4
        loop    OutputDoubleWord

        call    CrLf
        call    WaitMsg
        invoke  ExitProcess, 0
Testing ENDP

ShiftArray PROC
        pushad
        mov     edx, 0
        mov     ebx, [eax]
        shrd    [eax], edx, 1
        add     eax, 4

        mov     ecx, 4
ShiftDoubleWord:
        mov     edx, ebx
        mov     ebx, [eax]
        shrd    [eax], edx, 1
        add     eax, 4
        loop    ShiftDoubleWord

        popad
        ret
ShiftArray ENDP

END Testing
