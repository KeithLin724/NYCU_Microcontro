KEY     EQU P0 
    SPEAKER EQU P3.0 
    ROW     EQU R0
    TMP     EQU R1
    TIME     EQU R2
    TEMPO     EQU R3
    TONE     EQU R4
    TONE2     EQU R5
    ORG     00H
    AJMP     START
START:
    MOV     KEY,#11111111B            ;????
    MOV     TMOD,#0                ;timer0,1 mod0
    MOV     TL0,#0                    ;??
    MOV     TH0,#0
    SETB     TR0                        ;????
MAIN:
    MOV     KEY,#11111111B
    MOV     ROW,#01111111B            ;???row
    MOV     TMP,#0
    MOV     TIME,#4                    ;??4?
SEARCH:
    MOV     KEY,ROW
    JNB     KEY.0,SOUND_SHOW
    INC     TMP
    JNB     KEY.1,SOUND_SHOW
    INC     TMP
    JNB     KEY.2,SOUND_SHOW
    INC     TMP
    INC     TMP
    MOV     A,ROW
    RR     A                            ;????
    MOV     ROW,A
    DJNZ     TIME,SEARCH
    JMP     MAIN
SOUND_SHOW:
    CALL     DELAY
    MOV    DPTR,# TABLE_TONE
    MOV     A,TMP
    MOVC     A,@A+DPTR
    MOV     TONE,A                 ;??TONE

    MOV     DPTR,#TABLE_TONE2
    MOV     A,TMP
    MOVC     A    ,@A+DPTR
    MOV     TONE2,A                 ;??TONE2


SOUND:
    MOV     TIME,#1
SOUND1:
    SETB     SPEAKER                ;BUZZER ON
    CALL     SDELAY 
    CLR     SPEAKER                ;BUZZER OFF
    CALL     SDELAY 
    DJNZ     TIME,SOUND1
    DJNZ     TEMPO,SOUND
    JMP     MAIN
SDELAY:
    MOV     TL0,TONE2                 ;TL0??TONE2
    MOV     TH0,TONE                 ;TH0??TONE
    JNB     TF0,$ 
    CLR     TF0                     ;TF0=0
    RET

DELAY:
    MOV R6,#0100
DELAY1:
    MOV R7,#0100
DELAY2:
    DJNZ R7,DELAY2
    DJNZ R6,DELAY1
    RET        ;????????
TABLE_TONE:
    DB 196,216,196,00
    DB 202,218,209,00
    DB 209,224,218,00
    DB 212,226,212,00
TABLE_TONE2:
    DB 20,10,20,00
    DB 28,16,4,00
    DB 4,24,16,00
    DB 8,10,8,00
TABLE_TONE3:
    DB 131,196,131,00
    DB 147,220,165,00
    DB 165,247,220,00

END