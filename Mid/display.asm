    org 0000H
    ajmp main
    org 0050H

LCD_set equ p3 
LCD_data_bus equ p2 
LCD_Light_with_counter equ p0
counter equ r0
display_pos equ r1 
keyboard equ p1 
scanner equ r2 
get_check_bit equ r3 
save equ r4 

main:
    mov scanner , #01111111b // for keyboard  
    mov LCD_Light_with_counter , #0 //for keyboard counter 

init_LCD:
    acall Delay_cmd 
    acall Delay_cmd //for lcd setup 

    mov a , #00111011b // cmd set up
    acall set_up_cmd 

    mov a , #00001100b // set no curso , no flash 
    acall set_up_cmd

    mov a , #1 
    acall set_up_cmd 

    acall Delay_cmd 
    acall Delay_cmd // for clear screan 

CG_upload_data:
    mov a , #01000000b // set ac to CG_ram to 0H 
    acall set_up_cmd 
    mov dptr , #table_carton 
Up_load_Loop: // for upload data 
    clr a 
    movc a , @a+dptr 
    jz mode_string_dptr 
    acall upload_data 
    inc dptr 

    jmp Up_load_Loop // for loop upload data 

mode_string_dptr:
    //setup game 
    mov dptr , #mode_set_string
    mov a , #10000000b // set ddram to 0 
    acall set_up_cmd
mode_string_show:
    clr a 
    movc a , @a+dptr 
    jz Read // for end 
    acall upload_data 
    inc dptr 
    jmp mode_string_show 

Read_init:
    mov a , LCD_Light_with_counter 
    anl a , #10001111b 
    mov LCD_Light_with_counter , a
Read:
    mov keyboard , scanner 
    lcall Delay_keyboard 
    //after 
    mov a , keyboard 
    swap a 
    anl a , #11110000b
    mov get_check_bit , a 

    mov a , get_check_bit 
    xrl a , #0E0H
    jz first_col
    mov a , get_check_bit 
    xrl a , #0D0H 
    jz second_col
    mov a , get_check_bit 
    xrl a , #0B0H 
    jz third_col
    mov a , get_check_bit 
    xrl a , #070H 
    jz four_col
    inc LCD_Light_with_counter
    mov a , scanner 
    rr a 
    mov scanner , a 
    cjne r1 , #0F7H , Read
    mov a , LCD_Light_with_counter
    anl a , #10000000b
    mov LCD_Light_with_counter , a 

    jmp Read_init


first_col: // 0 4 8 C //out = counter * 4 +0
    mov a , LCD_Light_with_counter 
    anl a , #10001111b
    mov b , #4 
    mul ab //out in a 
    mov save , a 
    jmp Read_init //show ans 
second_col: //1 5 9 d //out = counter*4 +2
    mov a , LCD_Light_with_counter 
    anl a , #10001111b
    mov b , #4 
    mul ab //out in a 
    add a , #2
    mov save , a  
    xrl a , #14
    jz m2 

    jmp Read_init
third_col: // 3 7 E m3  //out = counter*4 +3 
    mov a , LCD_Light_with_counter // counter to a 
    anl a , #10001111b
    mov b , #4 
    mul ab //out in a 
    add a , #3
    mov save , a

    xrl a , #15
    jz m3

    jmp Read_init
four_col: // 4 8 rest m4  //out = counter*4 +4  
    mov a , LCD_Light_with_counter 
    anl a , #10001111b
    mov b , #4 
    mul ab //out in a 
    add a , #4

    mov save , a  
    xrl a , #16
    jz light_on

    mov a , save 
    xrl a , #12 
    jz re 

    jmp Read
re:
    ljmp Read_init 

light_on:
    cpl LCD_Light_with_counter.7 
    mov a , #00001111b // set no curso , no flash 
    acall set_up_cmd
spice_loop:
    mov dptr , #Sppp
    mov a , #10000000b // set ddram to 0 
    acall set_up_cmd 
spice_loop2:
    clr a 
    movc a , @a+dptr 
    acall upload_data 
    inc dptr 
    jmp spice_loop2
    
    ljmp Read
m2:
    mov a , #1 
    acall set_up_cmd 

    acall Delay_cmd 
    acall Delay_cmd // for clear screan 
    mov a , #01000000b // set ac to CG_ram to 0H 
    acall set_up_cmd 
show_loop_init_m2:
    mov counter , #0 // set counter 
show_loop_m2:
    mov a , #10000000b// set ddram to 0 
    acall set_up_cmd 

    mov a , counter // set ac to ddr 00H 
    acall upload_data 
    acall delay

    inc counter 
    cjne counter , #2 , show_loop_m2 
    jmp show_loop_init_m2

m3:
    mov a , #1 
    acall set_up_cmd 

    acall Delay_cmd 
    acall Delay_cmd // for clear screan 
    mov a , #01000000b // set ac to CG_ram to 0H 
    acall set_up_cmd 

show_loop_init_display:
    mov display_pos , #0080H
    mov counter , #0000H // set counter 
show_loop:
    mov a , display_pos // set ddram to 0 
    acall set_up_cmd 

    mov a , counter // set ac to ddr 00H 
    acall upload_data 
    acall delay

    inc counter 
    cjne counter , #0002H , show_loop 
    mov counter , #0000H // set counter 
    inc display_pos

    mov a , #1 
    acall set_up_cmd
    acall Delay_cmd 
    acall Delay_cmd // for clear screan 

    cjne display_pos , #090H , show_loop 
m3_2:
    mov a , #1 
    acall set_up_cmd 

    acall Delay_cmd 
    acall Delay_cmd // for clear screan 
    mov a , #01000000b // set ac to CG_ram to 0H 
    acall set_up_cmd 

    mov display_pos , #00CFH 
    mov counter , #0000H 
show_loop_down:
    mov a , display_pos // set ddram to 0 
    acall set_up_cmd 

    mov a , counter // set ac to ddr 00H 
    acall upload_data 
    acall delay

    inc counter 
    cjne counter , #0002H , show_loop_down 
    mov counter , #0000H // set counter 
    dec display_pos

    mov a , #1 
    acall set_up_cmd
    acall Delay_cmd 
    acall Delay_cmd // for clear screan 

    cjne display_pos , #0BFH , show_loop_down 

    jmp show_loop_init_display

set_up_cmd: // for set up 
    mov LCD_data_bus , a 
    acall Delay_cmd 

    mov LCD_set , #00000100b 
    acall Delay_cmd 

    mov LCD_set , #00000000b 
    acall Delay_cmd 
    ret 

upload_data:
    mov LCD_data_bus , a 
    acall Delay_cmd 
    
    mov LCD_set , #00000101b
    acall Delay_cmd 

    mov LCD_set , #00000001b 
    acall Delay_cmd 
    ret

Delay_cmd:
	mov r5,#0010H
Del1:
	mov r6,#0F0H
Del2:
	mov r7,#10
Del3:
	djnz r7,Del3
	djnz r6,Del2
	djnz r5,Del1
	ret

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

Delay_keyboard:
    mov r5,#00AH
Del_k1:
	mov r6,#00AH
Del_k2:
	mov r7,#1H
Del_k3:
	djnz r7,Del_k3
	djnz r6,Del_k2
	djnz r5,Del_k1
	ret

mode_set_string: // for init 
    db "Mode Setting" , 0 
Sppp:
    db "     " , 0 


table_carton:
    db 00AH , 080H , 080H , 01FH , 01FH , 080H , 080H , 080H // 0FFH = null 
    db 00AH , 080H , 01FH , 011H , 011H , 01FH , 080H , 080H
    db 0  

    end 
