#include <REG_MPC82G516.H>
#include "package.h"
#include <STDIO.H>
#include <STDLIB.H>

Byte state = 0;//0  pict dic : 1 is rand ans 
Byte dic_num = 1; // min is 1 : max is 8
Byte total_dot = 0; // about dic 
Byte pos = 0x80; // display position 
Byte i = 0;
Byte can_show = 0; // false ;
Byte clean = 0; // for clear screen

Byte Dic_arr[8];

char num_str_for_fun[4];

void dic_pick_inter_input() interrupt 0 using 2 { // pick dic and random it

    switch (state) {
    case 0:
        dic_num++;
        if (dic_num > 8) {
            dic_num = 1;
        }

        LCDSetUpCmd(0xC0);
        LCDUploadData(dic_num + '0');

        break;
    case 1:
        //LCDSetUpCmd(0x01);
        total_dot = 0;
        for (i = 0; i < dic_num; i++) {
            Dic_arr[i] = rand() % 6 + 1;
            total_dot += Dic_arr[i];
        }

        pos = 0x80;
        for (i = 0; i < dic_num; i++) {
            LCDSetUpCmd(pos);
            LCDUploadData(Dic_arr[i] + '0');
            pos += 2;
        }


        LCDSetUpCmd(0xC9);
        LCD_upload_str("  ");

        if (total_dot > 10) {
            LCDUploadData(total_dot / 10 + '0');
            LCDUploadData(total_dot % 10 + '0');
        }
        else {
            LCDUploadData(total_dot + '0');
        }


        break;
    default:
        break;
    }
}

void mode_change_inter() interrupt 2 using 2 {
    state++;

    if (state > 1) { // only 0 and 1 
        state = 0;
        //can_show = 0;// can not show ; 
        clean = 1;
    }
    LCDSetUpCmd(0x01);
    if (state == 1) {

        LCDSetUpCmd(LCD_DDram[LCD_DOWN]);
        LCD_upload_str("total is ");

    }
    else {
        //LCDSetUpCmd(0x01);
        LCDSetUpCmd(LCD_DDram[LCD_UP]); // set ddram to 0x80 is 0 0xC0
        LCD_upload_str("pick dic : ");
    }
}




void main() {
    // open INT0
    IT0 = 1; /// falling edge 
    EX0 = 1;

    IT1 = 1;
    EX1 = 1;

    PX0 = 1;
    EA = 1;
    //

    state = 1;
    total_dot = 0;
    dic_num = 1;

    LCDInit();

    while (1) { // main loop
        /* code */
        switch (state) {
        case 0:
            break;
        case 1:
            break;
        default:
            break;
        }


    }
}