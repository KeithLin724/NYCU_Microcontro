    org 0000H
    ajmp init_setup
    org 0003H
    ljmp exip 
    org 0050H

    p4 equ 0C0H
    table_index equ r0 
    col_num equ r1 
    save_start equ r2 

init_setup: // set internal 
    setb it0 //higt to low 
    setb ex0 //enable trigger 0
    clr ie0 //set flag = 0 
    setb px0 // set frist otion 
    setb ea // trun on all tigger  
    mov save_start , #95 // start index 
    mov dptr , #table_let_me_pass

main: // main funcrion 
Loop:
    mov p0 , #0 
    mov p1 , #0FFH // no light 
    mov p2 , #0FFH 
    mov p4 , #0FFH 
    ajmp Loop 


exip: // internal function 
    mov p0 , #0FFH // all light on in p0 
    mov p1 , #0 
    acall led_let_me_pass_show 
    cjne save_start , #255 , dec_fun // if show finish
    mov save_start , #189 // start last word 
    reti

dec_fun:
    dec save_start // right shift 
    dec save_start 
    reti

led_let_me_pass_show:
    mov a , save_start
    mov table_index , a
    mov col_num , #48 
col_run_show:
    acall add_fun_move_a
    mov p2 , a //even 
    acall add_fun_move_a 
    mov p4 , a // ood 
    acall delay 
    djnz col_num , col_run_show
    ret 

add_fun_move_a:
    inc table_index
    mov a , table_index 
    movc a , @a+dptr 
    ret 

delay:
    mov r7,#10
delay1:
    mov r6,#40
delay2:
    djnz r6,delay2
    djnz r7,delay1
    ret

    
table_let_me_pass: 
;space
    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH

    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH

    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
;別
    db 0FFH,07FH,0C1H,0BFH,0DDH,0CFH,05DH,0F0H
    db 0DDH,0BDH,0DDH,07DH,0DDH,0BDH,0C1H,0C1H
    db 0FFH,0FFH,0FFH,0FFH,007H,0F0H,0FFH,0BFH
    db 0FFH,07FH,000H,080H,0FFH,0FFH,0FFH,0FFH 
;當
    db  0DFH,0FFH,0E7H,0FFH,0F7H,003H,015H,0AAH
    db  0D3H,0AAH,0D7H,0AAH,0D7H,0AAH,0D0H,082H
    db  0D7H,0AAH,0D7H,0AAH,0D3H,0AAH,015H,0AAH
    db  0F7H,003H,0D7H,0FFH,0E7H,0FFH,0FFH,0FFH  

;me 
    db  0DFH,0FFH,0DBH,0F7H,0DBH,0B7H,0DBH,07BH
    db  001H,080H,0DCH,0FDH,0DDH,0BEH,0DFH,0BFH
    db  0DFH,0DFH,000H,0ECH,0DFH,0F3H,0DDH,0EBH
    db  0D3H,0DDH,05FH,0BEH,0DFH,007H,0FFH,0FFH

;space
    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH

    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH

    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
    db  0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
    end 