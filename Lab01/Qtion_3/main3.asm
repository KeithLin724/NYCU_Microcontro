    ORG 0000H
    AJMP MAIN 
    ORG 0050H
MAIN:
    MOV R0,#0FFH; make a value in R0
    CLR C ;clear carry  
LOOP:
    MOV A , R0 ;move R0 to A  
    RRC A      ; right shift and put carry in A 
    MOV P1, A  ; move A to P1  
    CPL C      ; opposite carry 
    MOV R0,A   ; move A to R0 
    
    ACALL DELAY;  Absolutely call delay function
    JMP LOOP   ; jump  to label "LOOP"
DELAY:

DELAY:
    MOV R5,#0FFH;  
DELAY1:
    MOV R6,#0FFH; 
DELAY2:
    MOV R7,#05H;  
DELAY3:
    djnz R7,DELAY3 
    djnz R6,DELAY2 
    djnz R5,DELAY1 
    RET  
    END