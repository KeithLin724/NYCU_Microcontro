org 0000H
ajmp main 
org 0050H

M equ 66
N equ 66

main:
    mov a , #00010001b // contro move  
    mov r0 , #0 ; 
    mov r1 , #0 ; 

    
Loop: // small 
    mov p0 , a //1000
    acall delay 
    rl a
    inc r0 
    cjne r0 , #2 , Loop //onl
    mov r0 , #0     
    inc r1 

    cjne r1 , #83, Loop 
    mov r0 , #0 
    mov r1 , #0 

    mov a , #10001000b
    //acall del // for L 90 
Loop1: // more //744
    mov p0 , a 
    acall delay 
    rr a
    inc r0 
    cjne r0 , #4 , Loop1 //onl
    mov r0 , #0     
    inc r1 
    
    cjne r1 , #83 ,Loop1
    mov r0 , #0 
    mov r1 , #0

    ajmp Loop ; 

delay: 
    mov r5,#009H
delay1:
	mov r6,#00CH
delay2:
    mov r7,#06AH
delay3:
	djnz r7,delay3
	djnz r6,delay2
    djnz r5,delay1 
	ret
end 