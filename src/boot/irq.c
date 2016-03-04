#include "irq.h"
#include "debug-write.h"

void init_irq(void)
{
    init_irq_hw();
}

void handle_interrupt(unsigned int line)
{    
    interrupt_handler_t handler = interrupt_vector[line];
    if (handler)
    {
        (*handler)();
    }
    // error
}

void disable_interrupt_handler(int line)
{
    interrupt_vector[line] = 0;
    irq_disable_hw(line);
}

void register_interrupt_handler(int line, interrupt_handler_t handler)
{
    interrupt_vector[line] = handler;
    irq_enable_hw(line);
}

void c_irq_handler(void)
{
    c_irq_handler_hw();
}


void c_undef_handler(void)
{
    debug_write_string("c_undef_handler: \n\r", 19);
    debug_write_string("HANG\n\r", 6);
}

void c_prefetch_abort(void)
{
    debug_write_string("c_prefetch_abort: \n\r", 20);
    debug_write_string("HANG\n\r", 6);
}

void c_data_abort(void)
{
    debug_write_string("c_data_abort: \n\r", 16);
    debug_write_string("HANG\n\r", 6);
}

void c_unused(void)
{
    debug_write_string("c_unused: \n\r", 12);
    debug_write_string("HANG\n\r", 6);
}

void c_fiq_vector(void)
{
    debug_write_string("c_fiq_vector: \n\r", 16);
    debug_write_string("HANG\n\r", 6);
}
