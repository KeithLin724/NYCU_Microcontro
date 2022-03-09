    org 0000H
    ajmp init_set
    org 000BH
    ajmp timerR0
    org 0013H
    ajmp int1_trigger 
    org 0050H

ss_dis_loca_ptr equ r0 
save_ss_dis_loca equ r1 
ss_display equ p0 
ss_display_out_loca equ p2 

init_set:
    setb et0 // open timer0 
    setb it1 // set int1 setting high to low 
    setb ex1 // open int1 
    setb px1  //setting int1 first list 
    setb ea // start all 

    mov TMOD , #11010010b // set timer0 mode2 and counter1 mode 1 
    mov th0,#227 // overflow dis
    mov tl0,#227 // mode2 auto reload 

    mov th1,#0 // counter1 init 1 mode 1 
    mov tl1,#0 // 

    setb tr0 // start timer0 
    setb tr1  // start counter 1 
    clr tf0 // clear timer0 
    clr ie1 // clear int1 flag 
    mov dptr,#num_table  // set table 

start_show:
    mov ss_dis_loca_ptr , #40H // array //43H 42H , 41H , 40H 
    mov save_ss_dis_loca , #11111110b

show:
    mov a , @ss_dis_loca_ptr
    movc a , @a+dptr 
    mov ss_display , a 

    inc ss_dis_loca_ptr
    mov ss_display_out_loca , save_ss_dis_loca

    acall delay 
    mov ss_display_out_loca , #0FFH

    mov a , save_ss_dis_loca // rl save_ss_dis_loca 
    rl  a 
    mov save_ss_dis_loca , a 

    cjne save_ss_dis_loca,#11101111b , show // shift 
    ajmp start_show 

timerR0:
    clr tf0 // clear // but it is auto reload 
    cpl p1.0 // make sq 
    reti 

int1_trigger: // get trigger // r2 r3 r4 
    clr tr1 // stop counter 1 
    clr tr0 // stop timer r0 
    // 256 * n alg
    mov r2 , th1 // get high bit  // save to r2 
    
/////////////////////
    mov a , r2 
    mov b , #6 
    mul ab // 6*in 
    
    mov b , #10 
    div ab // get mod to b  
    
    mov 37H , a // save to 37 // carry 
    mov 30H , b // add to r4 
/////////////////////////
    mov a , r2 
    mov b , #5 
    mul ab // 5*in 
    add a , 37H 

    mov b , #10 
    div ab // get mod to b  
    
    mov 37H , a // save to r3 // carry 
    mov 31H , b // add to r4 
/////////////////////////
    mov a , r2 
    mov b , #2
    mul ab // 2*in 
    add a , 37H 

    mov b , #10 
    div ab // get mod to b  
    
    mov 37H , a // save to r3 // carry 
    mov 32H , b // add to r4 
    /////////////////////
    ///////////////////
    //////finish r4 
    
    mov a , tl1 // check squr 
    mov b , #100 // take X00
    div ab 
    mov 42H,a

    mov a ,b 
    mov b , #10
    div ab 
    mov 41H,  a // take 0X0
    mov 40H , b // take 00X
//////////////////////////////////
//37H is reg 

    mov a , 30H // 000X
    add a , 40H 
    mov b , #10 
    div ab 
    mov 40H , b 
    mov 37H , a // save to reg 

    mov a , 31H //00X0
    add a , 41H 
    add a , 37H // add carry 
    mov b , #10 
    div ab 
    mov 41H , b 
    mov 37H , a // save to reg 

    mov a , 32H //0X00
    add a , 42H 
    add a , 37H // add carry 
    mov b , #10 
    div ab 
    mov 42H , b 
    mov 43H , a // save to reg 

    mov 37H , #0

    mov tl1 , #0 // init th1 and tl1 
    mov th1 , #0 

    setb tr0 
    setb tr1 
    reti 

delay: // delay function  
	mov r5,#20
delay1:
	mov r6,#25
delay2:
	djnz r6,delay2
	djnz r5,delay1
	ret

num_table:
    db	0C0H, 0F9H,	0A4H, 0B0H,	099H //0 1 2 3 4 
	db	092H, 082H,	0F8H, 080H,	090H //5 6 7 8 9
    end 
