INCLUDE Irvine32.inc

.const
        TRUE = 1
        FALSE = 0
        MAX_CREDITS = 30
        MIN_CREDITS = 1
        MAX_AVERAGE = 400
        MIN_AVERAGE = 0

.data
        gradeAverage    SWORD    275
        credits         SWORD    12
        OkToRegister    BYTE    ?
        msgInvalidCred  BYTE    "ERROR! Credits value cant be greater than 30 and less than 1", 0
        msgInvalidAver  BYTE    "ERROR! Average grade cant be greater than 400 and less than 0", 0
        msgAverage      BYTE    "Input student's average grade", 0
        msgCredits      BYTE    "Input exam grade student counts on", 0
        msgPass         BYTE    "Student can be registered", 0
        msgFail         BYTE    "Student can NOT be registered", 0
        msgRepeat       BYTE    "Press SPACE to check again, another key to exit", 0

.code

main PROC
Start:
        call    ClrScr
        call    GetAverage
        call    GetCredits

        mov     OkToRegister, FALSE
        cmp     gradeAverage, 350
        ja      LPass
        cmp     credits, 12
        jbe     LPass
        cmp     gradeAverage, 250
        jb      LResult
        cmp     credits, 16
        jbe     LPass
        jmp     LResult

LPass:
        mov     OkToRegister, TRUE

LResult:
        call    OutputResult
        call    CrLf

LQuit::
        call    CrLf
        mov     edx, OFFSET msgRepeat
        call    WriteString
        xor     eax, eax
        call    ReadChar
        cmp     al, ' '
        je      Start

        invoke  ExitProcess, 0
main ENDP

OutputResult PROC USES eax edx
        xor     eax, eax
        mov     al, OkToRegister
        or      eax, eax
        jnz     LPositiveResult
        mov     edx, OFFSET msgFail
        jmp     LGetResult

LPositiveResult:
        mov     edx, OFFSET msgPass

LGetResult:
        call    WriteString
        ret
OutputResult ENDP

GetAverage PROC USES eax edx
        mov     edx, OFFSET msgAverage
        call    WriteString
        call    CrLf
        xor     eax, eax
        call    ReadInt

        cmp     eax, MIN_AVERAGE
        jl      LAverageFail
        cmp     eax, MAX_AVERAGE
        jg      LAverageFail
        jmp     LAverageEndCheck

LAverageFail:
        mov     edx, OFFSET msgInvalidAver
        call    WriteString
        call    CrLf
        jmp     LQuit

LAverageEndCheck:
        mov     gradeAverage, ax

        ret
GetAverage ENDP

GetCredits PROC
        mov     edx, OFFSET msgCredits
        call    WriteString
        call    CrLf
        xor     eax, eax
        call    ReadInt

        cmp     eax, MIN_CREDITS
        jl      LCreditsFail
        cmp     eax, MAX_CREDITS
        jg      LCreditsFail
        jmp     LCreditsEndCheck

LCreditsFail:
        mov     edx, OFFSET msgInvalidCred
        call    WriteString
        call    CrLf
        jmp     LQuit

LCreditsEndCheck:
        mov     credits, ax

        ret
GetCredits ENDP

END main
