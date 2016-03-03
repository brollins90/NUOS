#include "swi.h"


void loop(char d)
{
    unsigned int i;
    char c[] = { d };
    c[0] = d;
    while (1) {
        for (i = 0x00000fff; i > 0; i--)
        {
        }
        user_write(1, c, 1);
    }
}

static volatile char loopChar = 'a';

void kernel_main( unsigned int r0, unsigned int r1, unsigned int atags )
{
    debug_write_string("kernel start\n\r", 14);
    debug_write_reg();
    
    debug_write_string("enable int\n\r", 12);
    _enable_interrupts();
    debug_write_reg();
    
    debug_write_string("loop ", 5);
    debug_write_char(loopChar);
    debug_write_string("\n\r", 2);
    loop(loopChar++);
    
    /* Never exit as there is no OS to exit to! */
    while(1) { }
}
