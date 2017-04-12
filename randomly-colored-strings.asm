INCLUDE Irvine32.inc

.const
        REPEATS_QUANTITY = 20

.data
        specifiedString     BYTE    "This is a string", 0

.code

main PROC
        call    Randomize
        mov     ecx, REPEATS_QUANTITY
        mov     edx, OFFSET specifiedString
OutputString:
        call    GetRandomStringColor
        call    WriteString
        call    CrLf
        loop    OutputString

        mov     eax, white + (black * 16)
        call    SetTextColor
        call    WaitMsg
        invoke  ExitProcess, 0
main ENDP

GetRandomStringColor PROC USES eax
        mov     eax, 10
        call    RandomRange

        cmp     eax, 2
        jbe     WhiteColor
        cmp     eax, 3
        je      BlueColor
GreenColor:
        mov     eax, green + (black * 16)
        jmp     Quit
WhiteColor:
        mov     eax, white + (black * 16)
        jmp     Quit
BlueColor:
        mov     eax, blue + (black * 16)

Quit:
        call    SetTextColor
        ret
GetRandomStringColor ENDP


END main
