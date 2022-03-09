    org 0000H
    ajmp main
    org 000BH
    ajmp timer0 
    org 0050H

sound_port equ p0.0

main:
    mov tmod, #00100001b
    mov tl1 , #0E6H
    mov th1 , #0E6H

    setb tr1 
    clr sm2 
    setb sm1
    clr sm0 
    setb ren 

    setb et0 
    clr tf0
    setb ea 
    mov dptr , #table 
    clr tr0 
receive:
    clr ri
    jnb ri , $

process:
    mov a , sbuf 
    subb a , #48 
    dec a 
    mov b , #2
    mul ab
    mov b , a 
    movc a , @a+dptr 
    mov r0 , a 
    mov a,b 
    inc a 
    movc a , @a+dptr 
    mov r1 , a 
    setb tr0 
    acall delay1s
    clr tr0 
    ajmp receive

timer0:
    cpl sound_port
    mov th0 , r0 
    mov tl0 , r1 
    reti 


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

table:
    db 0F1H , 018H
    db 0F2H , 0B6H
    db 0F4H , 02AH
    db 0F4H , 0D6H
    db 0F6H , 009H
    db 0F7H , 01FH
    db 0F8H , 0EDH
    
     

    end 