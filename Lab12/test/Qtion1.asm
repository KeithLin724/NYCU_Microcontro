    org 0000H 
    ajmp main
    org 0050H

main:
    mov tmod , #00100000b //timer1 mode2 
    mov tl1 , #0FDH  //2400 // 
    mov th1 , #0FDH    
    orl pcon , #080H   //smod = 1 
    

    
    setb tr1 
    clr sm2 
    setb sm1 // set mode variable baud rate 
    clr sm0 
    setb ren // enable recive 

receive:
    clr ri 
    jnb ri , $
process:
    mov a , sbuf 
    add a , #32 
    clr ti 
send:  
    mov sbuf , a 
    jnb ti , $
    ajmp receive

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

    end  