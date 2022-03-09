    org 0000H 
    ajmp main  
    org 0050H 

main:
init_table: // not change  
    mov dptr , #Big_table // set init table  
init_set:  
    mov r0 , #10000000b // r0 is display  
    mov r1 , #0 // display time 0~19  
    mov r2 , #0 // dptr index  0~4  
    mov r3 , #0 //table choose 0 ~ 2   
loop: 
    mov a , r2 ; // choose  
    movc a , @a + dptr  
    mov p0 , a  

    mov a , r0  
    mov p1 , a  
    rr a  
    mov r0 , a  
    acall delay  

    inc r2 // next ptr  
    cjne r0 , #00000100b , loop ; display col  
    mov r0 , #10000000b // reset r0  
    mov r2 , #0 // reset dptr index  
    inc r1  

    cjne r1 , #020H , loop ;display time  
    mov r1 ,#0  
    // change dptr  
    inc r3  
    cjne r3 , #3 , no_reset 
    mov r3 , #0 // reset r3 display ptr  
no_reset: 
    mov a , #0  
    xrl a , r3  
    jz  change_Big // if is 0  
    
    mov a , #1 
    xrl a , r3 
    jz  change_Mid // if is 1  
    
    mov a , #2 
    xrl a , r3 
    jz  change_Small // if is 2  

change_end: 
    ajmp loop // end loop  

Big_table: 
    db	00010010b
	db	00010100b
	db	01111000b
	db	00010100b
	db	00010010b
Mid_table: 
    db	00111110b
	db	00100010b
	db	01111111b
	db	00100010b
	db	00111110b

Small_table: 
    db	00001000b
	db	00010001b
	db	01111111b
	db	00010000b
	db	00001000b

change_Big: 
    mov dptr , #Big_table 
    jmp change_end 

change_Mid: 
    mov dptr, #Mid_table 
    jmp change_end 

change_Small: 
    mov dptr,#Small_table 
    jmp change_end  

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
    end  