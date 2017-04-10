INCLUDE Irvine32.inc

.const
        RANDOM_CHAR_LIMIT = 25
        RANDOM_CHAR_CORRECTOR = 65
        RANDOM_ROW_LIMIT = 25
        RANDOM_COLUMN_LIMIT = 80
        REPEATS_QUANTITY = 100
        RANDOM_TIME_LIMIT = 291
        RANDOM_TIME_CORRECTOR = 10

.code

main PROC
        call    Randomize
        mov     ecx, REPEATS_QUANTITY
        call    RandomChar
OutputSymbol:
        call    RandomXY
        call    Gotoxy
        mov     ebx, eax        ; generated char backup
        call    RandomDelayTime
        call    Delay
        mov     eax, ebx        ; generated char recovery
        call    WriteChar
        loop    OutputSymbol

        invoke  ExitProcess, 0
main ENDP

RandomChar PROC
; RECIEVES: -
; RETURNS:  eax: random char
        mov     eax, RANDOM_CHAR_LIMIT
        call    RandomRange
        add     eax, RANDOM_CHAR_CORRECTOR
        
        ret
RandomChar ENDP

RandomDelayTime PROC
; RECIEVES: -
; RETURNS:  eax: random delay time
        mov     eax, RANDOM_TIME_LIMIT
        call    RandomRange
        add     eax, RANDOM_TIME_CORRECTOR 
        
        ret
RandomDelayTime ENDP

RandomXY PROC USES eax
; RECIEVES: -
; RETURNS:  dh: random row for Gotoxy
;           dl: random column for Gotoxy
        xor     edx, edx
        mov     eax, RANDOM_ROW_LIMIT
        call    RandomRange
        mov     dh, al
        mov     eax, RANDOM_COLUMN_LIMIT
        call    RandomRange
        mov     dl, al

        ret
RandomXY ENDP

END main

