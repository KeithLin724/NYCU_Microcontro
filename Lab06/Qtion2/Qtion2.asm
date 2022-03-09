    org 0000H
    ajmp main 
    org 0050H
main:
    mov dptr , #show_table // set up table 
    mov r0 , #0 // get check bit
    mov r1 , #01111111b // for run 
    mov r2 , #0 //counter 

    mov r3 , #0 //for display 
    mov r4 , #0 // for display time 
Loop:
Read: //keyboard // let p3 for read 
    // first col 
    mov p3 , r1 // out first row 
    acall Delay_keyboard // delay for input 
    // after 
    mov a , p3 // save input 
    swap a // get last 4 bits to first bits 
    anl a , #11110000b
    mov r0 , a // save to r0 

    mov a , r0 
    xrl a , #0E0H
    jz first_col
    mov a , r0 
    xrl a , #0D0H 
    jz second_col
    mov a , r0 
    xrl a , #0B0H 
    jz third_col
    mov a , r0 
    xrl a , #070H 
    jz four_col
    //next row 
    inc r2 // add counter 
    mov a , r1
    rr a 
    mov r1 , a 
    cjne r1 , #0F7H , Read 

    mov r1 , #01111111b // init 
    mov r2 , #0 // init counter 
    mov r3 , #00AH  
    //mov r3 , #0

Show_fun: // show function 
    mov p1 , #0FFH 
    mov p0 , #07FH // 1
    acall delay
    inc r4 

    mov p1 , #0FFH 
    mov p0 , #0BFH // 2
    acall delay

    cjne r3 , #011H , yes
    mov p1 , #0FFH 
    mov p0 , #0DFH // 3
    acall delay

    mov p1 , #0FFH 
    mov p0 , #0EFH // 4
    acall delay

    jmp must 
yes:
    mov a , r3 
    mov b , #10
    div ab 
    da a  
    cjne a , #0 , super_yes
    mov a , #00AH 
super_yes:
    movc a , @a+dptr
    mov p1 , a // display frist 
    mov p0 , #0DFH // 3
    acall delay

    mov a , b 
    movc a , @a+dptr
    mov p1 , a // display frist 
    mov p0 , #0EFH // 4
    acall delay
must:
    cjne r4 , #00FH , Show_fun
    mov r4 , #0 // init dislpay time 
    ajmp Loop // to main loop

first_col: 
    //out = counter * 4 
    mov a , r2 
    mov b , #4 
    mul ab //out in a 
    mov r3 ,a 
    jmp Show_fun //show ans 

second_col:
    //out = counter*4 +1 
    mov a , r2 
    mov b , #4 
    mul ab //out in a 
    add a , #1 
    mov r3 , a  
    jmp Show_fun

third_col:
    //out = counter*4 +2 
    mov a , r2 // counter to a 
    mov b , #4 
    mul ab //out in a 
    add a , #2
    mov r3 , a
    jmp Show_fun

four_col: 
    //out = counter*4 +3  
    mov a , r2 
    mov b , #4 
    mul ab //out in a 
    add a , #3
    mov r3 , a
    jmp Show_fun

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

delay:
	mov r5,#0FFH
delay1:
	mov r6,#00FH
delay2:
	mov r7,#1H
delay3:
	djnz r7,delay3
	djnz r6,delay2
	djnz r5,delay1
	ret

show_table:
    //0 1 2 3 4 
    db	0C0H, 0F9H,	0A4H, 0B0H,	099H
    //5 6 7 8 9
	db	092H, 082H,	0F8H, 080H,	090H	
    db 0FFH // NULL
    end  