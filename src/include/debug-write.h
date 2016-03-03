#ifndef DEBUG_WRITE_H
#define DEBUG_WRITE_H

void debug_write_char(char c);
void debug_write_hex(int i);
void debug_write_reg();
void debug_write_string(char* c, int len);

void debug_write_end();
void debug_write_start();

#endif