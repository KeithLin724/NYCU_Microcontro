    org 0000H
    ajmp main
    org 0050H

LCD_set equ p3 
LCD_data_bus equ p0 
counter equ r0
display_pos equ r1 

main:
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
    mov dptr , #mov_table 
Up_load_Loop:
    clr a 
    movc a , @a+dptr 
    jz show_loop_init_display 
    acall upload_data 
    inc dptr 

    jmp Up_load_Loop 
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
	mov r5,#10
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

mov_table: // 16 
    db 004H , 00AH , 004H , 01FH , 004H 
    db 00AH , 011H , 080H , 004H , 00AH
    db 015H , 00EH , 004H , 00AH , 080H 
    db 0 

    end 