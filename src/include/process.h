#ifndef PROCESS_H
#define PROCESS_H

#define MAX_PROCESSES 2

typedef struct process_control_block {
    unsigned int stack_pointer;
} process_control_block;

extern process_control_block process_table[];
extern unsigned int CurrentThread;
extern unsigned int ThreadCount;

unsigned int create(void* functionAddress, unsigned int stackPointer);

#endif