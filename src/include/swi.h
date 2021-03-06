#ifndef SWI_H
#define SWI_H

#include <sys/stat.h>
#include <sys/times.h>

void c_swi_handler();

#define SYSCALL_NONE        0
#define SYSCALL_EXIT        1
#define SYSCALL_EXECVE      2
#define SYSCALL_FORK        3
#define SYSCALL_GETPID      4
#define SYSCALL_KILL        5
#define SYSCALL_TIMES       6
#define SYSCALL_OPEN        7
#define SYSCALL_CLOSE       8
#define SYSCALL_ISATTY      9
#define SYSCALL_STAT        10
#define SYSCALL_FSTAT       11
#define SYSCALL_LSEEK       12
#define SYSCALL_READ        13
#define SYSCALL_WRITE       14
#define SYSCALL_LINK        15
#define SYSCALL_UNLINK      16
#define SYSCALL_SBRK        17

void sys_none(void);
void sys_exit(int status);
int sys_execve(char *name, char **argv, char **env);
int sys_fork(void);
int sys_getpid(void);
int sys_kill(int pid, int sig);
clock_t sys_times(struct tms *buf);
int sys_open(const char *name, int flags, int mode);
int sys_close(int file);
int sys_isatty(int file);
int sys_stat(const char *file, struct stat *st);
int sys_fstat(int file, struct stat *st);
int sys_lseek(int file, int ptr, int dir);
int sys_read(int file, char *ptr, int len);
int sys_write(int file, char *ptr, int len);
int sys_link(void);
int sys_unlink(char *name);
caddr_t sys_sbrk(int incr);

void user_none(void);
void user_exit(int status);
int user_execve(char *name, char **argv, char **env);
int user_fork(void);
int user_getpid(void);
int user_kill(int pid, int sig);
clock_t user_times(struct tms *buf);
int user_open(const char *name, int flags, int mode);
int user_close(int file);
int user_isatty(int file);
int user_stat(const char *file, struct stat *st);
int user_fstat(int file, struct stat *st);
int user_lseek(int file, int ptr, int dir);
int user_read(int file, char *ptr, int len);
int user_write(int file, char *ptr, int len);
int user_link(void);
int user_unlink(char *name);
caddr_t user_sbrk(int incr);

#endif