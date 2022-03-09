    org 0000H
    ajmp main 
    org 000BH 
    ajmp timer0
    org 001BH 
    ajmp timer1
    org 0050H

sound_out equ p0.0
counter_index equ r2 
counter_1 equ r4
counter_2 equ 47H
delay_counter equ r5 


main:
    clr sound_out 
    mov tmod , #00100001b //timer1 mode2 // timer0 mode1

    setb et0 //
    setb et1 
    setb ea
init:

    clr sound_out 
    mov counter_index , #0 
    mov delay_counter , #0


    mov tl1 , #176 ;timer1 delay 50ms 
    mov th1 , #60 ; 
    //setb tr1 ; timer1 start 
    mov dptr , #scale // table 

init_ctr_index:
    mov counter_index , #0 ; 

Loop:
    mov a , counter_index 
    mov b , #3
    mul ab 

    mov b , a 
    movc a , @a+dptr 
    mov r0 , a // get high bit  
    mov a , b 
    inc a 
    movc a , @a+dptr 
    mov r1 , a

    inc a 
    mov r3 , a 

    mov th0 , r0 
    mov tl0 , r1

for_2:
    mov counter_1 , #4
for_1:
    setb tr0 //open re
    cjne counter_1 , #0 , for_1
    mov counter_1 , #4 
    djnz counter_2 , for_1 
    clr tr0 // end sqt

    setb tr1 
    cjne delay_counter , #20 , $ 
    clr tr1 

    inc counter_index
    cjne counter_index , #11 , Loop 
    mov counter_index , #0 

    jmp Loop 


timer0:
    mov th0, r0 
    mov tl0, r1
    cpl sound_out 
    dec counter_1 
    reti 
timer1:
    mov tl1 , #176 ;timer1 delay 50ms 
    mov th1 , #176 ; 
    inc delay_counter 

    reti 

scale:
    db  252,69,131
    db  252,124,139
    db  252,173,147
    db  252,222,156
    db  253,10,165
    db  253,53,175
    db  253,92,185
    db  253,130,196
    db  253,167,208
    db  253,199,220
    db  253,231,233
    db  254,5,247
end 