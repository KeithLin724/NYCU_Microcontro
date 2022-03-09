    ORG 0000H
    AJMP MAIN
    ORG 0050H

MAIN:
    MOV R0 , #07H // counter
    MOV R1 , P0 // befor data
    MOV R2 , #00H // use for copy counter
    MOV A , P0 // init set up 
    MOV P1 , A // init display 
LOOP:
    MOV A , R1 // move befor data to compare 
    XRL A , P0 // compare

    JNZ RO   // if A == 1 to RO  
    // else 
    MOV A , P1
    RL A 
TOLOOP: 
    MOV P1 , A // display 

    DEC R0 // counter -1 
    MOV A , R0 // move to A to check 
    JZ ADDINIT //use A to set R0 to init 
TOLOOPS:
    ACALL DELAY // delay 
    JMP LOOP // jump to LOOP

ADDINIT: // set R0 to number 7 
    MOV R0 , #07H 
    JMP TOLOOPS ; 

RO:  // use counter to let input data to shift RL how many time 
    MOV A , R0 // do copy
    MOV R2 , A // set copy counter 
    MOV A , P0 // copy display 

    MOV R1 , A  // save before
    MOV A , R1 
DOO: // end of RL of conter //return // like "for" statement 
    DJNZ R2 ,RROO 
    JMP TOLOOP // end the for loop

RROO: // function 
    RL A //do shift
    JMP DOO

// delay function 
DELAY:
    MOV R5,#0FFH;  
DELAY1:
    MOV R6,#0FFH; 
DELAY2:
    MOV R7,#05H;  
DELAY3:
    DJNZ R7,DELAY3 
    DJNZ R6,DELAY2 
    DJNZ R5,DELAY1 
    RET  
    END