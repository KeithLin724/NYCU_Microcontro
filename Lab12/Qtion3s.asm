$NOMOD51   
$INCLUDE(REG_MPC82G516.INC)

    org 0000H
    ajmp main
    org 000BH
    ajmp timer0
    org 0013H
    ajmp int1_trigger

    org 0050H

//sound_port equ p0.0
Baud_h equ 0FFH //9600
Baud_l equ 0D9H

out_sq equ p1.1
out_save1 equ r0 
out_save2 equ r1 
count_10 equ r2


main:  
init_set:
    //timer0 and 1 
    mov tmod , #11100001b // timer0->timer mode 1 ; timer1 ->counter mode2

    mov th0 , #158 // cal huz 
    mov tl0 , #88
    
    mov th1 , #0
    mov tl1 , #0 
    // timer2 
    mov t2con , #00110000b 
    mov RCAP2H , #Baud_h
    mov RCAP2L , #Baud_l




    orl pcon , #80H 
    setb tr2 
    clr sm2 
    setb sm1 // open sm mode 1 
    clr sm0 
    setb ren // open recive 
    setb px1


    //setb et0 
    //clr tf0
    setb ea 

    clr tf0 // clear timer0 
    clr ie1 // clear int1 flag

    mov out_save1 , #0 
    mov out_save2 , #0
/////////////
timer0: // if is 20 
    clr tf0 
    mov th0 , #158 // cal huz 
    mov tl0 , #88
    inc count_10
    cjne count_10 , #10 , end_tr0
    cpl out_sq
    mov count_10 , #0 
end_tr0:
    reti 
///////////////////


/////////////////
int1_trigger:
    cpl tr0 
    cpl tr1 

    reti 

/////////////////
     

to_serise_table:
    db '0','1' , '2'
op_H_sp_table:
    db ' ' , 'H' , '\n'

end