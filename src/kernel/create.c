#include "debug-write.h"
#include "process.h"

unsigned int create(void* functionAddress, unsigned int stackPointer)
{
    debug_write_string("\n\rcreate ", 9);
    unsigned int process_id = ThreadCount++;
    debug_write_hex(process_id);
    debug_write_hex(ThreadCount);
    debug_write_hex((int) functionAddress);
    debug_write_hex(stackPointer);
    debug_write_string("\n\r", 2);
    
    process_control_block* newProcess = &process_table[process_id];
    
    newProcess->stack_pointer = stackPointer;
    
    _put32(stackPointer, (int)functionAddress); // r0
    _put32(stackPointer + 1 * 4, (int)functionAddress); // r1
    _put32(stackPointer + 2 * 4, (int)functionAddress); // r2
    _put32(stackPointer + 3 * 4, (int)functionAddress); // r3
    _put32(stackPointer + 4 * 4, (int)functionAddress); // r4
    _put32(stackPointer + 5 * 4, (int)functionAddress); // r5
    _put32(stackPointer + 6 * 4, (int)functionAddress); // r6
    _put32(stackPointer + 7 * 4, (int)functionAddress); // r7
    _put32(stackPointer + 8 * 4, (int)functionAddress); // r8
    _put32(stackPointer + 9 * 4, (int)functionAddress); // r9
    _put32(stackPointer + 10 * 4, (int)functionAddress); // r10
    _put32(stackPointer + 11 * 4, (int)functionAddress); // r11
    _put32(stackPointer + 12 * 4, (int)functionAddress); // r12
    _put32(stackPointer + 13 * 4, (int)functionAddress); // lr
    
    return process_id;
}
