INCLUDE Irvine32.inc

.data
        msgPrompt           BYTE    "Please enter a number to check. (-1 to exit)", 0
        msgNegativeAnswer   BYTE    "Number is NOT prime.", 0
        msgPositiveAnswer   BYTE    "Number is prime", 0
        msgIncorrectInput   BYTE    "Incorrect value. Check is not possible.", 0

.code

main PROC
LGetNumber:
        mov     edx, OFFSET msgPrompt
        call    WriteString
        call    CrLf
        call    ReadInt
        cmp     eax, -1
        je      LExit
        or      eax, eax
        js      LIncorrectInput
                
        call    IsNumberPrime
        jnz     LNegativeAnswer
        mov     edx, OFFSET msgPositiveAnswer
        call    WriteString
        jmp     LNextNumber
LNegativeAnswer:
        mov     edx, OFFSET msgNegativeAnswer
        call    WriteString
LNextNumber:
        call    CrLf
        call    CrLf
        jmp     LGetNumber

LIncorrectInput:
       mov      edx, OFFSET msgIncorrectInput
       call     WriteString
       call     CrLf
       call     CrLf
       jmp      LGetNumber

LExit:
        call    CrLf
        call    WaitMsg
        invoke  ExitProcess, 0
main ENDP

IsNumberPrime PROC
.data
        buffVariable        DWORD   ?

.code
        pushad

        cmp     eax, 1
        jle     LPrime
        
        finit
        mov     buffVariable, eax
        fild    buffVariable
        fsqrt   
        fistp   buffVariable

        mov     ebx, eax
        mov     ecx, 2
LSearch:
        mov     eax, ebx
        xor     edx, edx
        div     ecx
        or      edx, edx
        jz      LNotPrime
        
        cmp     ecx, buffVariable
        je      LPrime
        inc     ecx
        jmp     LSearch

LPrime:
        sub     eax, eax    ; ZF = 1
        jmp     LExitCheck
LNotPrime:
        or      eax, eax    ; ZF = 0
        
LExitCheck:
        popad
        ret
IsNumberPrime ENDP

END main
