$NOMOD51   
$INCLUDE(REG_MPC82G516.INC)
   
    org 0000H
    ajmp main 
    org 0050H

Baud_h equ 0FFH //9600
Baud_l equ 0D9H
//th2 equ RCAP2H
//tl2 equ RCAP2L
main:
init_set:
    mov t2con , #00110000b 
    //mov tmod , #00100000b //timer1 mode2 
    //mov tl1 , #Baud //2400 baud rate 
    //mov th1 , #Baud 
    mov RCAP2H , #Baud_h
    mov RCAP2L , #Baud_l
    
    orl pcon , #80H 
    setb tr2
    //setb tr1 // open timer 1 
    clr sm2 
    setb sm1 // asynchronous mode1
    clr sm0 
    setb ren // enable recive 

receive:
    clr ri 
    jnb ri , $ 

process: // get fi
    mov a , sbuf 
    add a , #32 // ascii small to  big 
    clr ti // clrear flag
send: // send function 
    mov sbuf , a 
    jnb ti , $ 
    ajmp receive

 
    end 