/* 
 * File:   Trafficlight.c
 * Author: jkp
 *
 * Created on October 5, 2014, 11:08 AM
 */

// PIC12F683 Configuration Bit Settings

// 'C' source line config statements

#include <xc.h>

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

// CONFIG
#pragma config FOSC = INTOSCIO  // Oscillator Selection bits (INTOSCIO oscillator: I/O function on RA4/OSC2/CLKOUT pin, I/O function on RA5/OSC1/CLKIN)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config MCLRE = ON       // MCLR Pin Function Select bit (MCLR pin function is digital input, MCLR internally tied to VDD)
#pragma config CP = OFF         // Code Protection bit (Program memory code protection is disabled)
#pragma config CPD = OFF        // Data Code Protection bit (Data memory code protection is disabled)
#pragma config BOREN = OFF      // Brown Out Detect (BOR disabled)
#pragma config IESO = OFF       // Internal External Switchover bit (Internal External Switchover mode is disabled)
#pragma config FCMEN = OFF      // Fail-Safe Clock Monitor Enabled bit (Fail-Safe Clock Monitor is disabled)



#include <stdio.h>
#include <stdlib.h>

char stateval[8] = {18, 34, 34, 38, 33, 36, 34, 34};

char statetri[8] = {4, 16, 4, 0, 4, 2, 4, 0};

void setState(char s) {
    TRISIO = statetri[s];
    GPIO = stateval[s];
}

#define _XTAL_FREQ 32000
#define __delay_ms(x) _delay((unsigned long)((x)*(_XTAL_FREQ/4000.0)))

int main(int argc, char** argv) {
    OSCCONbits.IRCF = 0;
    GPIO = 0;
    TRISIO = 0;
    WPU = 0;
    int sleepcounter = 0;
    while (1 == 1) {
        setState(0); // R G
        __delay_ms(10000);
        setState(1); // R Y
        __delay_ms(1500);
        setState(2); // R R
        __delay_ms(1500);
        setState(3); // RY R
        __delay_ms(1500);
        setState(4); // G R
        __delay_ms(10000);
        setState(5); // Y R
        __delay_ms(1500);
        setState(6); // R R
        __delay_ms(1500);
        setState(7); // R RY
        __delay_ms(1500);
        if (++sleepcounter >= 30) {
            GPIO=0;
            SLEEP();
        }
    }
    return (EXIT_SUCCESS);
}

