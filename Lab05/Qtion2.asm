    org 0000H 
    ajmp main  
    org 0050H 
main:
    mov r0 , #10000000b // run x
    mov r1 , #10000000b // run y

loop:
    mov a , r0
    mov p1 , a // display frist 
    rr a
    mov r0 , a 

    mov a , r1 
    mov p0 , a 

    acall delay

    cjne r0 , #00000100b , loop
    mov r0 , #10000000b

    mov a , r1 
    rr a 
    mov r1 , a

    ajmp loop 

delay:
	mov r5,#0FFH
delay1:
	mov r6,#0FFH
delay2:
	mov r7,#00FH
delay3:
	djnz r7,delay3
	djnz r6,delay2
	djnz r5,delay1
	ret

    end 