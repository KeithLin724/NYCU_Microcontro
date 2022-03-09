    org 0000H
    ajmp main 
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

receive:
    clr ri 
    jnb ri , $ 

process: // get fi
    mov a , sbuf 
    add a , #32 // ascii small to  big 
    clr ti // clrear fli
send: // send function 
    mov sbuf , a 
    jnb ti , $ 
    ajmp receive 




scale:
	db	126,131				;Do
	db	113,147			    ;Re
	db	100,165				;Mi
	db	95 ,175				;Fa
	db	85 ,196				;So
	db	75 ,220				;La
	db	67 ,247				;Si
    end 