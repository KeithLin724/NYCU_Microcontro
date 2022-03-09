    ORG 0000H
    AJMP MAIN
    ORG 0050H

main:
    MOV A , #7FH
LOOP:
    MOV P1 , A ; display 
    MOV A , P0 // input 
    //CPL A 
    ADD A , #0FH

    ACALL DELAY 
    MOV A , P1 ;
    RR A 

    JMP LOOP

DELAY:
    MOV R5,#0FFH;  
DELAY1:
    MOV R6,A; 
DELAY2:
    MOV R7,#05H;  
DELAY3:
    DJNZ R7,DELAY3 
    DJNZ R6,DELAY2 
    DJNZ R5,DELAY1 
    RET  
    END