org 0000H
ajmp main
org 0050H

main:
    mov dptr ,#num_table
set_init:
    mov r0 ,#0 // counter //show time V
    mov r1 ,#0 // a number V
    mov r2 ,#1 // ans // for show V
    //maybe
    mov r3 ,#0 // reg V
    mov r4 ,#0 //for save 
Loop:
    mov a , r2 // move ans to cal 
    mov b , #10
    div ab
    mov r4 , a // save 

    mov p1 , #0FFH // turn off all 
    mov a , b
    movc a , @a+dptr
    mov p0 , a // display frist 
    mov p1 , #0FEH // 4
    acall DELAY

    mov a , r4 // save
    mov b , #10
    div ab
    mov r4 , a // save

    mov p1 , #0FFH // turn off all 
    mov a , b
    movc a , @a+dptr
    mov p0 , a // display frist 
    mov p1 , #0FDH // 3 
    acall DELAY // delay 

    mov a , r4 // save
    mov b , #10
    div ab
    mov r4 , a // save

    mov p1 , #0FFH // turn off all 
    mov a , b
    movc a , @a+dptr
    mov p0 , a // display frist 
    mov p1 , #0FBH // 2 
    acall DELAY // delay 

    mov p1 , #0FFH 
    mov p0 , #0FFH // display frist 
    mov p1 , #0F7H // 1
    inc r0 
    acall DELAY // delay

    cjne r0 , #0FAH , Loop
    
    mov a , r2
    xrl a , #233 // if ans == 233 to r_init
    jz set_init
    mov r0 , #0

fun:
    mov a , r1 
    mov r3 , a // c=a 

    mov a , r2 
    mov r1 , a // a = b 

    mov a , r3
    add a , r2
    mov r2 , a 
    //finish of reg r3 
    ajmp Loop

//delay function
DELAY:
	MOV R5,#0FFH
DELAY1:
	MOV R6,#005H
DELAY2:
	MOV R7,#1H
DELAY3:
	DJNZ R7,DELAY3
	DJNZ R6,DELAY2
	DJNZ R5,DELAY1
	RET

num_table:
        //NULL 1 2 3 4 
    db	0FFH, 0F9H,	0A4H, 0B0H,	099H
        //5 6 7 8 9
	db	092H, 082H,	0F8H, 080H,	090H
    END