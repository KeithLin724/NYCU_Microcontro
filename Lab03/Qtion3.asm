org 0000H  
ajmp main  
org 0050H  

main:
    mov dptr , #NUM_Table // save table
    //mov r0 , #0 // counter
    mov r1 , #01H // compare counter 
    mov r2 , #0 // check data //for input 
loop:
    mov r1 , #01H // compare counter 
    mov r0 , #0 // counter
    mov a , p1 
    cpl a 
    mov r2 , a // save to r2 
    jz dis 
    //do function
start1:
    mov a , r2 // input ;p0 is output 
    xrl a , r1 
    jz dis1 // is seem to display if a == 0 
    //else 
    mov a , r1 //left shift  
    rl a 
    mov r1 ,a 
    inc r0 

    cjne r0, #8,start1 //if r0 != 8 to start1
    //else  
    jmp err 

dis1:
    inc r0 //fix index 

dis:
    //display
    mov a , r0 // conter 
    movc a , @a+dptr 
    mov p0 , a // display
    jmp loop //bake loop
err:
    mov a , #0FFH
    mov p0 , a 
    jmp loop 

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
    END 

