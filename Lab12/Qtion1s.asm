$NOMOD51   
$INCLUDE(REG_MPC82G516.INC)

    org 0000H
    ajmp main
    org 0050H

//sound_port equ p0.0
Baud_h equ 0FFH //9600
Baud_l equ 0D9H

display_port equ p1 

main:
    mov t2con , #00110000b 
    mov RCAP2H , #Baud_h
    mov RCAP2L , #Baud_l
    orl pcon , #80H 
    setb tr2 


    clr sm2 
    setb sm1 // open sm mode 1 
    clr sm0 
    setb ren // open recive 

    //setb et0 
    //clr tf0
    setb ea 
    mov dptr , #table 
    clr tr0 
receive:
    clr ri
    jnb ri , $

process:
    mov a , sbuf 
    subb a , #48 
    movc a , @a+dptr 
    mov display_port , a 

    //mov th0 , #126
    //mov tl0 , #126
    //setb tr0 
    //acall delay1s
    //clr tr0 


    ajmp receive

//timer0:
    //cpl sound_port
//    mov th0 , #126
////    mov tl0 , #126
    //reti 


/*
delay1s: // delay function  
	mov r5,#00FH
delay1:
	mov r6,#0FAH
delay2:
    mov r7,#0FFH 
delay3:
    djnz r7,delay3
	djnz r6,delay2
	djnz r5,delay1
	ret
*/

table:
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
    
    end 