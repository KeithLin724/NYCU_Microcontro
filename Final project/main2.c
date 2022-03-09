#include <REG_MPC82G516.H>
#include "package.h"
#include <STDIO.H>
#include <STDLIB.H>

#define MAX_MARK_STR 16
/////////player/////
///////////////////
//#define pos_ply_max 16 // play is in 0 

Byte pos = 0x8F; // 0 is lose // 1 is win // -1 unknow 
Byte game_state = 0; // 0 is new game // 1 is gameing // 2 is win_lose 
Byte blood = 1;// only 5 time 
Byte player_num = 0;

///////game string//////////
//const char win_str[] = { '-','-','W' , 'I' , 'N' , '-' , '-' , '\0' };
//const char Lose_str[] = { '-','-','L' , 'O' , 'S' , 'E' , '-' , '-' , '\0' };
//const char mark_str[] = { 'm', 'a', 'r', 'k', ':' , '\0' };
//const char new_game[] = { 'n', 'e', 'w', ' ', 'g', 'a', 'm', 'e'  , '\0' };

//////mark//////
signed short mark = 0;
char num_str_for_fun[MAX_MARK_STR];

void to_num_str(signed short num) {
    Byte i;
    for (i = 0; i < MAX_MARK_STR; i++) {
        num_str_for_fun[i] = '\0';
    }
    sprintf(num_str_for_fun, "%d", num);

}
////////////////
////////sys num rand //////
s_int8 sys_rand_num = 0;
///////
//////input ///////////
//Byte LCD_row = 0;
Byte clean = 0;

void int0_inter_input() interrupt 0 using 2 {

    switch (game_state) {
    case 0:
        game_state++;
        clean = 1;
        break;

    case 1:
        /* code */
        player_num++;
        if (player_num == 10) {
            player_num = 0;
        }
        //LCDSetUpCmd(0x01);

        break;
    case 2:
        game_state++;
        clean = 1;
        break;

    default:
        break;
    }

    //clean = 1;
}

Byte dl = 0;
///////////////////////
void main() {
    // open INT0
    IT0 = 1; /// falling edge 
    EX0 = 1;
    PX0 = 1;
    EA = 1;
    // 


    //LCD
    LCDInit();


    while (1) { // run main 
        /* code */
        LCDSetUpCmd(0x80); // set ddram to 0x80 is 0 0xC0


        switch (game_state) {
        case 0: // new game 
            LCD_upload_str("new game");
            break;
        case 1: // gameing 
            //LCD_upload_str(win_str);
            while (blood) {
                sys_rand_num = rand() % 58 - '0'; // 0 to 9
                /*for (; pos > 0; pos--) {
                    LCDUploadData()
                }*/

                while (pos > 0x8F) {
                    LCDSetUpCmd(0x80);
                    LCDUploadData((Byte)(player_num + '0'));
                    LCDSetUpCmd(pos);
                    LCDUploadData(sys_rand_num);
                    pos--;
                    for (dl = 0; dl < 100; dl++)
                        DelayMs(50);
                }
                pos = 0x8F;

                /*if () {
                    mark++;
                }*/
                (player_num + '0') == sys_rand_num ? mark++ : blood--;


            }


            break;
        case 2: // end game 
            LCD_upload_str("Try agin");
            LCDSetUpCmd(0xC0);
            to_num_str(mark);
            //
            LCD_upload_str("mark :");
            LCD_upload_str(num_str_for_fun);
            break;

        default:
            break;
        }

        if (clean) {
            LCDSetUpCmd(0x01);
            clean = 0;
        }


    }


}