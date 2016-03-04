#include "debug-write.h"
#include "process.h"
#include "scheduler.h"


void reschedule()
{
    process_control_block* oldProcess = &process_table[CurrentThread];
    CurrentThread = (CurrentThread < ThreadCount - 1) ? CurrentThread + 1 : 0;
    process_control_block* newProcess = &process_table[CurrentThread];
    /*
    debug_write_hex((int)&process_table);
    debug_write_hex(_get32((int)&process_table));
    debug_write_hex(ThreadCount);
    debug_write_hex(CurrentThread);
    debug_write_hex((int)oldProcess);
    debug_write_hex((int)newProcess);
    debug_write_hex(oldProcess->stack_pointer);
    debug_write_hex(newProcess->stack_pointer);
    debug_write_reg();
    
    debug_write_hex(_get_stack_pointer());
    debug_write_hex(_get_lr());
    */
    _context_switch(oldProcess, newProcess);
    /*_context_switch(oldProcess->stack_pointer, newProcess->stack_pointer);*/
    /*
    debug_write_hex(_get_stack_pointer());
    debug_write_hex(_get_lr());
    debug_write_reg();
    */
}
