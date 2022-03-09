#include <REG_MPC82G516.H>
#include "package.h"
#include <STDIO.H>
#include <STRING.H>
#include <STDLIB.H>

#define num_to_chr_f '0'
#define MAX_MARK_STR 16
/////////player/////
///////////////////
#define pos_ply_max 16 // play is in 0 

s_int8 game_win_lose = -1; // 0 is lose // 1 is win // -1 unknow 
Byte game_state = 255; // 0 is new game // 1 is gameing // 2 is win_lose 
Byte blood = 5;// only 5 time 
//s_int8 player_num = 0;

///////game string//////////
const char win_str[] = { '-','-','W' , 'I' , 'N' , '-' , '-' , '\0' };
const char Lose_str[] = { '-','-','L' , 'O' , 'S' , 'E' , '-' , '-' , '\0' };
const char mark_str[] = { 'm', 'a', 'r', 'k', ':' , '\0' };
const char new_game[] = { 'n', 'e', 'w', ' ', 'g', 'a', 'm', 'e'  , '\0' };
//////mark//////
signed short mark = 0;
char num_str_for_fun[MAX_MARK_STR];

void to_mark_str() {
    Byte i;
    for (i = 0; i < MAX_MARK_STR; i++) {
        num_str_for_fun[i] = '\0';
    }
    sprintf(num_str_for_fun, "%d", mark);

}
////////////////
////////sys num rand //////
s_int8 sys_rand_num = 0;
///////
//////input ///////////
//Byte LCD_row = 0;
Byte clean = 0;

void int0_inter_input() interrupt 0 using 2{
    //LCD_row = !LCD_row;
    game_state++;
    if (game_state == 3) {
        game_state = 0;
    }

    clean = 1;
}
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
        case 0:
            LCD_upload_str(new_game);
            break;
        case 1:
            LCD_upload_str(win_str);

            LCDSetUpCmd(0xC0);

            //
            mark = rand() % 10;
            to_mark_str();
            //
            LCD_upload_str(mark_str);
            LCD_upload_str(num_str_for_fun);
            break;
        case 2:
            LCD_upload_str(Lose_str);
            break;

        default:
            break;
        }



        if (clean) {
            LCDSetUpCmd(0x01);
            clean = 0;
        }
        /*for (i = 0; i < 3; i++) {
            P2 = new_game[i];
            DelayMs(20000);
        }*/


    }


}