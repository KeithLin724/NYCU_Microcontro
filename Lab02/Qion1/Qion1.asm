    ORG 0000H
    AJMP MAIN
    ORG 0050H

main:
    MOV A,P0
	CPL A
    MOV P1,A

    AJMP MAIN
    END