    ORG 0000H
    AJMP MAIN 
    ORG 0050H
MAIN:
    MOV R0,#07FH; make a data in R0 , number is 07FH 
    MOV R1,#0FEH;  make a data in R1 . number is 0FEH 

LOOP:
    MOV A,R0  ; move R0 to A
    ANL A,R1  ; Let A and R1 to action "AND" , and put in " A "
    MOV P1,A  ; put A to P1
    MOV A,R0  ; move R0 to A 
    RR A      ; right shift A 
    MOV R0,A  ; move A to R0
    MOV A,R1  ; move R1 to A 
    RL A      ; Left shift A 
    MOV R1,A  ; move A to R1
    ACALL DELAY ; Absolutely call delay function  
    JMP LOOP  ; jump  to label "LOOP"
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
