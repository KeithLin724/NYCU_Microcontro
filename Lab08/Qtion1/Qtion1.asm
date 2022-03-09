    org 0000H
    ajmp main
    org 0050H

LCD_set equ p0//p3 
LCD_data_bus equ p2//p0 
main:
init_LCD:
    acall Delay_cmd 
    acall Delay_cmd //for lcd setup 

    mov a , #00111011b // cmd set up
    acall set_up_cmd 

    mov a , #00001100b // set curso , no flash 
    acall set_up_cmd

    mov a , #1 
    acall set_up_cmd 

    acall Delay_cmd 
    acall Delay_cmd // for clear screan 

    mov a , #10000000b // set ddram to 0 
    acall set_up_cmd 

make_dptr:
    mov dptr , #ID_table
    mov a , #10000000b // set ddram to 0 
    acall set_up_cmd 
Loop:
    clr a 
    movc a , @a+dptr 
    jz make_dptr 
    acall upload_data 
    inc dptr 
    jmp Loop 

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

ID_table:
    db "109511276" , 0 
    end 