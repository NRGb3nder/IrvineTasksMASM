.686
.model flat, stdcall
.stack 4096

ExitProcess PROTO :DWORD
DumpRegs PROTO

.data
    	val1    SDWORD      8
    	val2    SDWORD      -15
    	val3    SDWORD      20    

.code

main PROC
        ; -val2 + 7 - val3 + val1
    
        xor     eax, eax
        neg     val2
        add     eax, val2   ; eax = 0Fh
        add     eax, 7      ; eax = 16h
        add     eax, val1   ; eax = 1Eh
        sub     eax, val3   ; eax = 0Ah
        call    DumpRegs

	xor     eax, eax
 	invoke  ExitProcess, 0 
main ENDP

END main
