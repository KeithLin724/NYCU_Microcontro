ORG	0000H
	AJMP	START
	ORG	0050H
M	EQU	180			
N	EQU	100			
START:
	MOV	R0,#0			
	MOV	A,#00010001B	

LOOP:					
	MOV	P1,A			
	RR		A				
	ACALL	DELAY			
	INC		R0				
	CJNE	R0,#M+1,LOOP	
	MOV	R0,#0			

LOOP1:						
	MOV	P1,A
	RL		A				
	ACALL	DELAY		
	INC		R0				
	CJNE	R0,#N+1,LOOP1	
	AJMP	START			
DELAY:				
	MOV	R6,#20
DELAY1:
	MOV	R7,#200
	DJNZ	R7,$				
	DJNZ	R6,DELAY1
	RET
    end 
