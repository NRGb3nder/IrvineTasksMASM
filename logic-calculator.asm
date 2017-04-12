INCLUDE Irvine32.inc

.data
        OptionTable        BYTE    '1'
                           DWORD   ProcessAND
        OPTION_SIZE = ($ - OptionTable)
                           BYTE    '2'
                           DWORD   ProcessOR
                           BYTE    '3'
                           DWORD   ProcessNOT
                           BYTE    '4'
                           DWORD   ProcessXOR
                           BYTE    '5'
                           DWORD   ProcessExit
        OPTION_QUANTITY = ($ - OptionTable) / OPTION_SIZE
        msgChoicePrompt    BYTE    "Choose operation: ", 0
        msgOption1         BYTE    "1. x AND y", 0
        msgOption2         BYTE    "2. x OR y", 0
        msgOption3         BYTE    "3. NOT x", 0
        msgOption4         BYTE    "4. x XOR y", 0
        msgOption5         BYTE    "5. Exit", 0
        msgInvalidChoice   BYTE    "Invalid choice! Must be 1-5 key", 0
        msgRepeatPrompt    BYTE    "To return to menu press SPACE, to exit press another key", 0
        msgFirstOperand    BYTE    "Input first hexadecimal operand", 0
        msgSecondOperand   BYTE    "Input second hexadecimal operand", 0
        msgOperand         BYTE    "Input a hexadecimal operand", 0
        msgResult          BYTE    "The result of operation is: ", 0

.code

main PROC
Start::
        call    ClrScr
        call    ShowMenu
        xor     eax, eax
        call    ReadChar

        mov     ebx, OFFSET OptionTable
        mov     ecx, OPTION_QUANTITY

Comparison:
        cmp     al, [ebx]
        jne     NextElement
        call    NEAR PTR [ebx + 1]
        jmp     ReturnPrompt

NextElement:
        add     ebx, OPTION_SIZE
        loop    Comparison
        call    ErrorNotification
        call    CrLf
        call    WaitMsg
        jmp     Start

ReturnPrompt:
        call    CrLf
        call    RepeatPrompt

Quit::
        invoke  ExitProcess, 0
main ENDP

ShowMenu PROC USES edx
        mov     edx, OFFSET msgChoicePrompt
        call    WriteStrCrLf
        mov     edx, OFFSET msgOption1
        call    WriteStrCrLf
        mov     edx, OFFSET msgOption2
        call    WriteStrCrLf
        mov     edx, OFFSET msgOption3
        call    WriteStrCrLf
        mov     edx, OFFSET msgOption4
        call    WriteStrCrLf
        mov     edx, OFFSET msgOption5
        call    WriteStrCrLf

        ret
ShowMenu ENDP

; Irvine's WriteString + CrLf
WriteStrCrLf PROC
        call    WriteString
        call    CrLf

        ret
WriteStrCrLf ENDP

; Notifies that menu choice is invalid
ErrorNotification PROC USES edx
        call    CrLf
        mov     edx, OFFSET msgInvalidChoice
        call    WriteString

        ret
ErrorNotification ENDP

; Operation AND
ProcessAND PROC USES eax ebx edx
        call    ClrScr
        mov     edx, OFFSET msgOption1
        call    WriteStrCrLf

        call    GetFirstOperand
        call    GetSecondOperand
        and     eax, ebx
        call    OutputOperationResult

        ret
ProcessAND ENDP

; Operation OR
ProcessOR PROC USES edx
        call    ClrScr
        mov     edx, OFFSET msgOption2
        call    WriteStrCrLf

        call    GetFirstOperand
        call    GetSecondOperand
        or      eax, ebx
        call    OutputOperationResult

        ret
ProcessOR ENDP

; Operation NOT
ProcessNOT PROC USES edx
        call    ClrScr
        mov     edx, OFFSET msgOption3
        call    WriteStrCrLf

        call    GetOperand
        not     eax
        call    OutputOperationResult

        ret
ProcessNOT ENDP

; Operation XOR
ProcessXOR PROC USES edx
        call    ClrScr
        mov     edx, OFFSET msgOption4
        call    WriteStrCrLf

        call    GetFirstOperand
        call    GetSecondOperand
        xor     eax, ebx
        call    OutputOperationResult

        ret
ProcessXOR ENDP

ProcessExit PROC
        jmp     Quit

        ret
ProcessExit ENDP

; For the one-operand operation
; Reads a hexadecimal value to eax
GetOperand PROC USES edx
        mov     edx, OFFSET msgOperand
        call    WriteStrCrLf
        call    ReadHex
        call    CrLf

        ret
GetOperand ENDP

; Reads a hexadecimal value to ebx
GetFirstOperand PROC USES eax edx
        mov     edx, OFFSET msgFirstOperand
        call    WriteStrCrLf
        call    ReadHex
        call    CrLf
        mov     ebx, eax

        ret
GetFirstOperand ENDP

; Reads a hexadecimal value to eax
GetSecondOperand PROC USES edx
        mov     edx, OFFSET msgSecondOperand
        call    WriteStrCrLf
        call    ReadHex
        call    CrLf

        ret
GetSecondOperand ENDP

; Outputs result (eax) of a logic operation
OutputOperationResult PROC USES edx
        mov     edx, OFFSET msgResult
        call    WriteStrCrLf
        call    WriteHex
        call    CrLf

        ret
OutputOperationResult ENDP

; Asks user to execute another operation
RepeatPrompt PROC USES eax edx
        mov     edx, OFFSET msgRepeatPrompt
        call    WriteStrCrLf
        xor     eax, eax
        call    ReadChar
        call    CrLf
        cmp     al, ' '
        je      Start
        jmp     Quit

        ret
RepeatPrompt ENDP

END main
