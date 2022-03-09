	org 0000H ; fake cmd of org  , make a data in 000H
    AJMP MAIN ; must jump to main 
    org 0050H ; put in 0050H

MAIN:
    mov a , #7fh ; make a data in a 
LOOP:    
	mov p1 , a ; move a data "A" to p1
    rr a ; Rotate Right a 

    acall DELAY ; call delay function 
    jmp LOOP ; jump to label "LOOP"

DELAY:
    MOV R5,#0FFH
DELAY1:
    MOV R6,#0FFH
DELAY2:
    MOV R7,#05H   
DELAY3:
    djnz R7,DELAY3
	djnz R6,DELAY2
	djnz R5,DELAY1
	RET 
    END  