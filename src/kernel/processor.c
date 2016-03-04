#include "init.h"
#include "process.h"

process_control_block process_table[MAX_PROCESSES];
unsigned int CurrentThread = 0;
unsigned int ThreadCount = 1;

void init_processor()
{
    
}
