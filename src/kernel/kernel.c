#include "process.h"
#include "swi.h"


static volatile char loopChar = 'a';

void loop()
{
    debug_write_string("loop\n\r", 6);
    unsigned int i,l;
    char c[] = { 'a' };
    c[0] = loopChar++;
    while (1) {
        for (l=0;l<10;l++){
            for (i = 0x00000fff; i > 0; i--)
            {
            }
            user_write(1, c, 1);
        }
        /*
        debug_write_reg();
        */
        reschedule();
        /*
        debug_write_reg();
        */
    }
}

void kernel_main( unsigned int r0, unsigned int r1, unsigned int atags )
{
    debug_write_string("kernel start\n\r", 14);
    
    create(&loop, 0x4000);
    create(&loop, 0x5000);
    /*
    debug_write_reg();
    */
    debug_write_string("enable int\n\r", 12);    
    _enable_interrupts();
    /*
    debug_write_reg();
    
    debug_write_string("loop ", 5);
    debug_write_char(loopChar);
    debug_write_string("\n\r", 2);
    */
    loop();
    
    /* Never exit as there is no OS to exit to! */
    while(1) { }
}
