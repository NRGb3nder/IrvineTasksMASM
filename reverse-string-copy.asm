.686
.model flat, stdcall
.stack 4096

ExitProcess PROTO :DWORD
DumpMem PROTO

.data
        source      BYTE    "This is the source string", 0
        target      BYTE    LENGTHOF source DUP(?), 0

.code

main PROC
        mov     esi, OFFSET source + SIZEOF source - 1
        mov     ebx, OFFSET target    
        mov     ecx, LENGTHOF source
Copy:   
        sub     esi, TYPE source
        mov     eax, [esi]
        mov     [ebx], eax
        add     ebx, TYPE target
        loop    Copy

        mov     esi, OFFSET target
        mov     ebx, 1
        mov     ecx, LENGTHOF target - 1
        call    DumpMem

        invoke  ExitProcess, 0 
main ENDP

END main