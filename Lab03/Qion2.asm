org 0000H  
ajmp main  
org 0050H  
main: 
    mov dptr , #table 
loop: 
    mov r0 , #0 
loop1: 
    mov a , r0  
    movc a , @a+dptr // *(a+dptr)
    mov p0 , a // display  
    inc r0 
    mov a , p1 // input  
    cpl a ; flip  
    ;add a , #00FH // more time
    acall DELAY // use input to change delay speed  
    cjne r0 , #9 , loop1 // not nine to loop1 
    ajmp loop  

table: 
    db 0F9H ;1 
    db 0C0H ;0 
    db 090H ;9 
    db 092H ;5 
    db 0F9H ;1 
    db 0F9H ;1 
    db 0A4H ;2 
    db 0F8H ;7 
    db 082H ;6 

DELAY:
    MOV R5,a;  // use for contro delay time 
    inc r5 
DELAY1:
    MOV R6,#0FFH; 
DELAY2:
    MOV R7,#15H;  
DELAY3:
    DJNZ R7,DELAY3 
    DJNZ R6,DELAY2 
    DJNZ R5,DELAY1 
    RET  
    END

