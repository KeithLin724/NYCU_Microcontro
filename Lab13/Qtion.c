#include <REG_MPC82G516.H>
#define Byte unsigned char
Byte get = 1;
void main() {
    T2CON = 0x30; //00110000b 
    RCAP2H = 0xff;
    RCAP2L = 0xd9;

    PCON = 0x80;
    TR2 = 1;
    SM2 = 0;
    SM1 = 1;
    SM0 = 0;
    REN = 1;
    SP = 0x20;


    while (1) {
        //send 
        RI = 0;
        while (!RI) {

        }
        //process 
        get = SBUF;
        get += 32;
        TI = 0;

        // send
        SBUF = get;
        while (!TI) {

        }


    }
}