    org 0000H
    ajmp main 
    org 0050H
main:
    mov r0 , #00000100b // init x
    mov r1 , #00000100b // y 
    //mov r2 , #0 // counter 
loop1: // frist Rl // second RR 
    mov a , r0
    rl a 
    mov r0 , a 
    mov p1 , a 
    
    mov a , r1 
    rl a
    mov r1 , a 
    mov p0 , a 
    
    acall delay
    cjne r1 , #00100000b , loop1
loop2:
    mov a , r0
    rl a 
    mov r0 , a 
    mov p1 , a 
    
    mov a , r1 
    rr a
    mov r1 , a 
    mov p0 , a 
    
    acall delay
    cjne r0 , #10000000b , loop2
loop3:
    mov a , r0
    rr a 
    mov r0 , a 
    mov p1 , a 
    
    mov a , r1 
    rr a
    mov r1 , a 
    mov p0 , a 
    
    acall delay
    cjne r1 , #00000010b , loop3
loop4:
    mov a , r0
    rr a 
    mov r0 , a 
    mov p1 , a 
    
    mov a , r1 
    rl a
    mov r1 , a 
    mov p0 , a 
    
    acall delay
    cjne r0 , #00001000b , loop4
    ajmp loop1

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