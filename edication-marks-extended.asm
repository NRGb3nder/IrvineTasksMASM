INCLUDE Irvine32.inc

.const
        MAX_SCORE_A = 100
        MAX_SCORE_B = 89
        MAX_SCORE_C = 79
        MAX_SCORE_D = 69
        MAX_SCORE_F = 59
        SCORE_MAX_LIMIT = 100

.data
        queryCounter      BYTE    0
        MarkTable         BYTE    MAX_SCORE_F
                          DWORD   ProcessF
        TABLE_ELEM_SIZE = ($ - MarkTable)
                          BYTE    MAX_SCORE_D
                          DWORD   ProcessD
                          BYTE    MAX_SCORE_C
                          DWORD   ProcessC
                          BYTE    MAX_SCORE_B
                          DWORD   ProcessB
                          BYTE    MAX_SCORE_A
                          DWORD   ProcessA
        MARKS_QUANTITY = ($ - MarkTable) / TABLE_ELEM_SIZE
        msgPrompt         BYTE    "Please enter your score 0-100 to get your mark", 0
        msgMarkFound      BYTE    "Your mark is: ", 0
        msgMarkNotFound   BYTE    "Mark with specified score not found.", 0
        msgContinue       BYTE    "Check another score? Press SPACE to repeat search", 0
        msgQueries        BYTE    "Queries quantity: ", 0
        msgError          BYTE    "Invalid value! Score should be in [0-100]", 0
.code

main PROC
Search:
        call    ClrScr
        mov     edx, OFFSET msgPrompt
        call    WriteString
        call    CrLf
        xor     eax, eax
        call    ReadInt
        call    CheckInput

        inc     queryCounter
        mov     ebx, OFFSET MarkTable
        mov     ecx, MARKS_QUANTITY

Comparison:
        cmp     al, [ebx]
        ja      CheckNextMark
        mov     edx, OFFSET msgMarkFound
        call    WriteString
        call    NEAR PTR [ebx + 1]
        call    WriteChar

        jmp     RepeatSearch

CheckNextMark:
        add     ebx, TABLE_ELEM_SIZE
        loop    Comparison
        mov     edx, OFFSET msgMarkNotFound
        call    WriteString

RepeatSearch:
        call    CrLf
        mov     edx, OFFSET msgContinue
        call    WriteString
        call    CrLf
        call    ReadChar
        cmp     al, ' '
        je      Search

QuitReport::
        call    CrLf
        mov     edx, OFFSET msgQueries
        call    WriteString
        xor     eax, eax
        mov     al, queryCounter
        call    WriteInt
        
        call    CrLf
        call    WaitMsg

        invoke  ExitProcess, 0
main ENDP

CheckInput PROC USES edx eflags
        cmp     al, SCORE_MAX_LIMIT
        jbe     Pass
        mov     edx, OFFSET msgError
        call    WriteString
        call    CrLf
        jmp     QuitReport

Pass:
        ret
CheckInput ENDP

ProcessA PROC
        mov     al, 'A'
        ret
ProcessA ENDP

ProcessB PROC
        mov     al, 'B'
        ret
ProcessB ENDP

ProcessC PROC
        mov     al, 'C'
        ret
ProcessC ENDP

ProcessD PROC
        mov     al, 'D'
        ret
ProcessD ENDP

ProcessF PROC
        mov     al, 'F'
        ret
ProcessF ENDP

END main
