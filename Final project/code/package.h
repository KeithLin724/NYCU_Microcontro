//

#ifndef __PACKAGE_H__
#define __PACKAGE_H__

#ifndef __REG_MPC82G516_H__
#include <REG_MPC82G516.H>
#endif
#include <intrins.h>


#define Byte unsigned char
#define s_int8 signed char
#define u_int16 unsigned short

void DelayMs(s_int8  mS);

//lCD pin set up
#define LCD_Data_Bus P2
#define LCD_RS P05
#define LCD_R_W P06
#define LCD_E P07
/////////////////
//LCD first row and secnod row 
const Byte LCD_DDram[2] = { 0x80  , 0xC0 };// 0x80 is first row 0xC0 is second row 
#define LCD_UP 0 
#define LCD_DOWN 1

//LCD function//
void LCDSetUpCmd(Byte thing) {
    LCD_Data_Bus = thing;

    DelayMs(20);

    LCD_E = 1;
    LCD_R_W = 0;
    LCD_RS = 0;

    DelayMs(20);
    LCD_E = 0;
    LCD_R_W = 0;
    LCD_RS = 0;

    DelayMs(20);
}

void LCDUploadData(Byte thing) {
    LCD_Data_Bus = thing;

    DelayMs(20);

    LCD_E = 1;
    LCD_R_W = 0;
    LCD_RS = 1;

    DelayMs(20);

    LCD_E = 0;
    LCD_R_W = 0;
    LCD_RS = 1;

    DelayMs(20);
}

void LCDInit() {
    DelayMs(40);
    LCDSetUpCmd(0x3B);// cmd set up //#00111011b // cmd set up
    LCDSetUpCmd(0x0C);// set no curso , no flash 
    LCDSetUpCmd(0x01);
    DelayMs(40);
}

void LCD_upload_str(char input_str[]) {
    Byte i = 0;
    while (input_str[i] != '\0') {
        LCDUploadData(input_str[i]);
        i++;
    }

}


void DelayMs(s_int8  mS) {
    u_int16 need_delay = 1000 * mS;
    TMOD = 0x01;
    need_delay = 65536 - need_delay;
    TH0 = need_delay / 256;
    TL0 = need_delay % 256;
    TR0 = 1;
    while (!TF0) {

    }
    TR0 = 0;
    TF0 = 0;

}

// table of seven display 
Byte ss_display_table[10] = { 0xc0 , 0xf9 ,0xa4 , 0xb0, 0x99, 0x82 , 0xf8,0x80,0x90 };

#endif