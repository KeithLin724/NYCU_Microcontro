org 0000H  
ajmp main  
org 0050H  
main: 
    mov dptr, #NUM_Table
loop: 
    mov r0 , #10
loop1: 
    mov a , r0  
    movc a , @a+dptr 
    mov p0 , a // display  
    dec r0 // r0 --  
    acall DELAY // call delay function  
    cjne r0 , #0 , loop1 // not zero to loop1 
    ajmp loop  

NUM_Table: // table for run display number  
    db 0C0H ;0 
    db 0F9H ;1 
    db 0A4H ;2 
    db 0B0H ;3 
    db 099H ;4 
    db 092H ;5 
    db 082H ;6 
    db 0F8H ;7 
    db 080H ;8 
    db 090H ;9 

DELAY:
    MOV R5,#0FFH;  
DELAY1:
    MOV R6,#0FFH; 
DELAY2:
    MOV R7,#0FH;  
DELAY3:
    DJNZ R7,DELAY3 
    DJNZ R6,DELAY2 
    DJNZ R5,DELAY1 
    RET  
    END

