    org 0000H
    ajmp main 
    org 000BH 
    ajmp timer0
    org 0050H

    sound_out equ p0.0

main:
init_set:
    mov tmod , #00100000b //timer1 mode2 
    mov tl1 , #0E6H //2400 baud rate 
    mov th1 , #0E6H 
    orl pcon , #80H 

    setb tr1 
    clr sm2 
    setb sm1 // asynchronous mode1
    clr sm0 
    setb ren // enable 

    setb et0 // enable timer0 
    clr tf0 //close timer flag 
    setb ea // enable all 
    mov dptr , #scale // get for table counder 
    clr tr0 // close timer0 


receive:
    clr ri 
    jnb ri , $ 

process: // get fi
    mov a , sbuf 
    sub a , #48 // ascii small to  big (ascii -48-1)*2 
    dec a 
    mov b , #2 
    mul ab 

    mov b , a 
    movc a , @a,dptr 
    mov r0 , a // get high bit  
    mov a , b 
    inc a 
    movc a , @a+dptr 
    mov r1 , a 
    setb tr0 
    acall delay1s 
    clr tr0 
    ajmp receive 



    clr ti // clrear fli
timer0:
    cpl sound_out 
    mov th0,r0 
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

scale:
	db	126,131				;Do
	db	113,147			    ;Re
	db	100,165				;Mi
	db	95 ,175				;Fa
	db	85 ,196				;So
	db	75 ,220				;La
	db	67 ,247				;Si
end 