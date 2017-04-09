INCLUDE Irvine32.inc

.data
        firstValue      SDWORD    ?
        secondValue     SDWORD    ?
        msgSum          BYTE      "Integers sum: ", 0
        msgFirstInt     BYTE      "Enter first integer value: ", 0
        msgSecondInt    BYTE      "Enter second integer value: ", 0  

.code

main PROC
        xor     edx, edx
        mov     dh, 12
        mov     dl, 40
        call    Gotoxy

        mov     ecx, 3
IntSummation:
        xor     eax, eax
        xor     ebx, ebx
        call    GetTwoIntegers
        call    OutputTwoIntegersSum
        loop    IntSummation

        invoke  ExitProcess, 0
main ENDP

GetTwoIntegers PROC USES edx
; RECIEVES: -
; RETURNS:  eax: second integer value
;           ebx: first integer value
        call    ClrScr

        mov     edx, OFFSET msgFirstInt
        call    WriteString
        call    ReadInt
        
        mov     edx, OFFSET msgSecondInt
        call    WriteString
        mov     ebx, eax
        call    ReadInt

        ret
GetTwoIntegers ENDP

OutputTwoIntegersSum PROC USES eax
; RECIEVES: eax: first integer summand
;           ebx: second integer summand
; RETURNS:  -
        call    ClrScr
        mov     edx, OFFSET msgSum
        call    WriteString

        add     eax, ebx
        call    WriteInt
        call    CrLf

        call    WaitMsg
        call    CrLf   
             
        ret
OutputTwoIntegersSum ENDP 

END main
