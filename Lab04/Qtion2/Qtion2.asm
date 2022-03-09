org 0000H
ajmp main
org 0050H

main:
    mov r0 , #0 //counter for loop
    mov r1 , #0 // bit 1 index 
    mov r2 , #0 // bit2 index 
    mov r3 , #5 // bit 3 index 
    mov r4 , #0 //bit 4 index 

    mov dptr ,#num_table
Loop:
    mov p1 , #0FFH // turn off all 

    mov a , r1
    movc a , @a+dptr
    mov p0 , a // display frist 
    mov p1 , #0F7H // 1
    inc r0 // r0 ++ // for total counter // for to second 

    acall DELAY // delay 

    mov p1 , #0FFH // turn off all 
    mov a , r2
    movc a , @a+dptr
    mov p0 , a // display frist 
    mov p1 , #0FBH // 2 
    acall DELAY // delay 

    mov p1 , #0FFH // turn off all 
    mov a , r3
    movc a , @a+dptr
    mov p0 , a // display frist 
    mov p1 , #0FDH // 3 
    acall DELAY // delay 

    mov p1 , #0FFH // turn off all 
    mov a , r4
    movc a , @a+dptr
    mov p0 , a // display frist 
    mov p1 , #0FEH // 4
    acall DELAY // delay 

    cjne r0 , #0FFH , Loop // loop  times // contro
    //else 
    //cjne r3 , #6 , fun2 // 60 if r3 == 0 
    mov a , r3
    xrl a , #6 // if r3 == 6 
    jz fun2 // to fun2
fun2_r:
    inc r4 //  lase one ++
    mov r0 , #0 // init counter 
    cjne r4 , #10 , Loop // if r4 < 10 to loop  
    //else 
fun:
    mov r4 , #0
    inc r3 // ++to bit 3 
    ajmp Loop // end function
//function
fun2:
    mov r3 , #0
    ajmp fun2_r

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
        //0 1 2 3 4 
    db	0C0H, 0F9H,	0A4H, 0B0H,	099H
        //5 6 7 8 9
	db	092H, 082H,	0F8H, 080H,	090H		

//show_location:
//    db 01111111b ,10111111b ,11011111b ,11101111b
    END