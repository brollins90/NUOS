#include "uart.h"

static char hex_letters[] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
static char buf[] = {'0','0','0','0','0','0','0','0'};

void debug_write_char(char c) 
{
    uart_send(c);
}

void debug_write_hex(int i)
{    
    debug_write_char('0');
    debug_write_char('x');

    int j=7;
    do
    {
        buf[j--] = hex_letters[i & 0xf];
        i = (i >> 4);
    } while(j >= 0);
    
    for(j = 0; j < 8; j++)
    {
        debug_write_char(buf[j]);
    }

    debug_write_char(' ');
}

void debug_write_string(char* c, int len) 
{
    int i;
    for (i = 0; i < len; i++) {
        debug_write_char(c[i]);
    }
}

void debug_write_reg()
{
    register int r0 asm("r0");
    register int r1 asm("r1");
    register int r2 asm("r2");
    register int r3 asm("r3");
    register int r4 asm("r4");
    register int r5 asm("r5");
    register int r6 asm("r6");
    register int r7 asm("r7");
    register int r8 asm("r8");
    register int r9 asm("r9");
    register int r10 asm("r10");
    register int r11 asm("r11");
    register int r12 asm("r12");
    register int r13 asm("r13");
    register int r14 asm("r14");
    register int r15 asm("r15");
    
    debug_write_string("\n\rr0: ", 6);
    debug_write_hex(r0);
    debug_write_string("\n\rr1: ", 6);
    debug_write_hex(r1);
    debug_write_string("\n\rr2: ", 6);
    debug_write_hex(r2);
    debug_write_string("\n\rr3: ", 6);
    debug_write_hex(r3);
    debug_write_string("\n\rr4: ", 6);
    debug_write_hex(r4);
    debug_write_string("\n\rr5: ", 6);
    debug_write_hex(r5);
    debug_write_string("\n\rr6: ", 6);
    debug_write_hex(r6);
    debug_write_string("\n\rr7: ", 6);
    debug_write_hex(r7);
    debug_write_string("\n\rr8: ", 6);
    debug_write_hex(r8);
    debug_write_string("\n\rr9: ", 6);
    debug_write_hex(r9);
    debug_write_string("\n\rr10: ", 7);
    debug_write_hex(r10);
    debug_write_string("\n\rr11: ", 7);
    debug_write_hex(r11);
    debug_write_string("\n\rr12: ", 7);
    debug_write_hex(r12);
    debug_write_string("\n\rr13: ", 7);
    debug_write_hex(r13);
    debug_write_string("\n\rr14: ", 7);
    debug_write_hex(r14);
    debug_write_string("\n\rr15: ", 7);
    debug_write_hex(r15);
    debug_write_string("\n\r0xe000: ", 10);
    debug_write_hex(_get32(0xe000));
    debug_write_string("\n\r", 2);
}

void debug_write_start()
{    
    debug_write_string("\n\rstart:\n\r", 10);
}
void debug_write_end()
{    
    debug_write_string("\n\rend:\n\r", 8);
}
