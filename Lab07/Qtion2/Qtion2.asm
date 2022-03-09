    org 0000H
    ajmp main 
    org 0050H

counter equ r0 
main:
    mov r2 , #01111111b // for run 
    mov r4 , #0 
//Loop:
Read:
    mov p3 , r2 
    acall Delay_keyboard
    mov a , p3 
    swap a 
    anl a , #11110000b
    mov r3 , a // save to r0 

    mov a , r3 
    xrl a , #0E0H
    jz first_col
    mov a , r3 
    xrl a , #0D0H 
    jz second_col
    mov a , r3 
    xrl a , #0B0H 
    jz third_col
    mov a , r3 
    xrl a , #070H 
    jz four_col

    inc r4  

    mov a , r2 
    rr a 
    mov r2 , a 
    cjne r2 , #0F7H , Read 
    mov r2 , #01111111b // for run 
    mov r4 , #0 
    jmp Read 

first_col: 
    //out = counter * 4 
    mov a , r4 
    mov r3 , #0 
    cjne r4 , #0 , dis1 
L1:
    acall anti_clock_ch 
    inc r3 
    cjne r3 , #1 , L1     
    jmp Read //show ans 
dis1:
    acall clock_ch 
    inc r3 
    cjne r3 , #1 , dis1
    jmp Read 

second_col:
    //out = counter*4 +1 
    mov a , r4 
    mov r3 , #0 
    cjne r4 , #0 , dis2 
L2:
    acall anti_clock_ch 
    inc r3 
    cjne r3 , #2 , L2
    jmp Read
dis2:
    acall clock_ch 
    inc r3 
    cjne r3 , #2 , dis2
    jmp Read 

third_col:
    //out = counter*4 +2 
    mov a , r4 // counter to a 
    mov r3 , #0 
    cjne r4 , #0 , dis3 
L3:
    acall anti_clock_ch 
    inc r3 
    cjne r3 , #3 , L3
    jmp Read
dis3:
    acall clock_ch 
    inc r3 
    cjne r3 , #3 , dis3
    jmp Read 

four_col: 
    //out = counter*4 +3  
    mov a , r4 

    mov r3 , #0 
    cjne r4 , #0 , dis4 
L4:
    acall anti_clock_ch 
    inc r3 
    cjne r3 , #4 , L4

    jmp Read

dis4:
    acall clock_ch 
    inc r3 
    cjne r3 , #4 , dis4
    jmp Read

clock_ch:
    mov r0 , #0 
    mov r1 , #0 
    mov a , #00010001b
clock_ch_1:
    mov p0 , a //1000
    acall delay_c 
    rl a
    inc r0 
    cjne r0 , #1 , clock_ch_1 //onl
    mov r0 , #0     
    inc r1 

    cjne r1 , #83, clock_ch_1 
    mov r0 , #0 
    mov r1 , #0 
    ret 
anti_clock_ch:
    mov r0 , #0 
    mov r1 , #0
    mov a , #10001000b
anti_clock_ch_1:
    mov p0 , a //1000
    acall delay_c 
    rr a
    inc r0 
    cjne r0 , #1 , anti_clock_ch_1 //onl
    mov r0 , #0     
    inc r1 

    cjne r1 , #83, anti_clock_ch_1 
    mov r0 , #0 
    mov r1 , #0 
    ret 

Delay_keyboard:
	mov r5,#00AH
Del1:
	mov r6,#00AH
Del2:
	mov r7,#1H
Del3:
	djnz r7,Del3
	djnz r6,Del2
	djnz r5,Del1
	ret
delay_c: 
    mov r5,#009H
delay1_c:
	mov r6,#00CH
delay2_c:
    mov r7,#06AH
delay3_c:
	djnz r7,delay3_c
	djnz r6,delay2_c
    djnz r5,delay1_c 
	ret
end 