    org 0000H
    ajmp main 
    org 000BH 
    ajmp timer0
    org 0050H

    sound_out equ p0.0

    k_row_run equ r2 
    k_chk_bit equ 41H 
    k_counter equ 42H 
    reg_1 equ 43H

    keyboard equ p1 
    Output_counter equ 44H 

    counter_1 equ r4
    counter_2 equ 47H

main:
init_set:
    clr sound_out
    mov tmod , #00100001b //timer1 mode2 
    mov tl1  , #0E6H //2400 baud rate 
    mov th1  , #0E6H 
    //orl pcon , #80H 

    //setb tr1 
    //clr sm2 
    //setb sm1 // asynchronous mode1
    //clr sm0 
    //setb ren // enable 
    // timer0
    setb et0 // enable timer0 
    clr tf0 //close timer0 flag 
    setb ea // enable all 


    mov dptr , #scale // get for table counder 
    clr tr0 // close timer0 

    // setup keyboard 
    mov k_chk_bit , #0 
    mov k_row_run , #01111111b // for run 
    mov k_counter , #0 
Loop:
Read: // for read keyboard
    mov keyboard , k_row_run
    acall Delay_keyboard

    mov a , keyboard 
    swap a // get last 4 bits to first bits 
    anl a , #0F0H
    mov reg_1 , a // save to r0

    mov a , reg_1 
    xrl a , #0E0H
    jz first_col

    mov a , reg_1 
    xrl a , #0D0H 
    jz second_col

    mov a , reg_1 
    xrl a , #0B0H 
    jz third_col

    mov a , reg_1 
    xrl a , #070H 
    jz four_col

    // new row 
    inc k_counter // add_counter 
    mov a, k_row_run
    rr a 
    mov k_row_run , a 
    cjne k_row_run , #0F7H , Read 

    mov k_row_run , #01111111b // for run 
    mov k_counter , #0  // init 

    jmp Read ;

first_col: // out //out = counter * 4 
    mov a , k_counter 
    mov b , #4 
    mul ab //out in a 
    mov Output_counter ,a 

    jmp process
second_col://out = counter*4 +1

    mov a , k_counter 
    mov b , #4 
    mul ab //out in a 
    add a , #1 
    mov Output_counter , a  

    jmp process
third_col: //out = counter*4 +2

    mov a , k_counter // counter to a 
    mov b , #4 
    mul ab //out in a 
    add a , #2
    mov Output_counter , a

    jmp process

four_col://out = counter*4 +3  

    mov a , k_counter 
    mov b , #4 
    mul ab //out in a 
    add a , #3
    mov Output_counter , a

    jmp process


//receive:
//    clr ri 
//    jnb ri , $ 

process: // get fi
    //mov a , sbuf 
    //sub a , #48 // ascii small to  big (ascii -48-1)*2 
    //dec a 

    ///////
    mov a , Output_counter 
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
    
    mov counter_1 , #4
    mov counter_2 , a

    ///// for (int i = 0 i < 523)
for_2:
    mov counter_1 , #4
for_1:
    setb tr0 //open re
    cjne counter_1 , #0 , for_1
    mov counter_1 , #4 
    djnz counter_2 , for_1 

    //djnz counter_1 , for_1
    //djnz counter_2 , for_2

    //mov counter_1 , #0
    //mov counter_2 , #0
    //////
    //acall delay1s 
    clr tr0 // end sqt

    ajmp Read 



    //clr ti // clrear fli
timer0:
    mov th0, r0 
    mov tl0, r1
    cpl sound_out 
    dec counter_1 
    reti 

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