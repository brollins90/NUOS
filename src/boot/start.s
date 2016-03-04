.equ    CPSR_IRQ_DISABLE,    0x80
.equ    CPSR_FIQ_DISABLE,    0x40

.equ    CPSR_USR_MODE,       0x10
.equ    CPSR_FIQ_MODE,       0x11
.equ    CPSR_IRQ_MODE,       0x12
.equ    CPSR_SVC_MODE,       0x13
.equ    CPSR_ABT_MODE,       0x17
.equ    CPSR_UND_MODE,       0x1B
.equ    CPSR_SYS_MODE,       0x1F

.equ    USR_STACK_TOP,       0x4000
.equ    FIQ_STACK_TOP,       0x4000
.equ    IRQ_STACK_TOP,       0x8000
.equ    SVC_STACK_TOP,       0x4000
.equ    ABT_STACK_TOP,       0x4000
.equ    UND_STACK_TOP,       0x4000
.equ    SYS_STACK_TOP,       0x8000000

.text
.code 32
.globl _start
_start:
    LDR pc, _reset_h
    LDR pc, _undef_vector_h
    LDR pc, _swi_vector_h
    LDR pc, _prefetch_abort_h
    LDR pc, _data_abort_h
    LDR pc, _unused_h
    LDR pc, _irq_vector_h
    LDR pc, _fiq_vector_h
_reset_h:           .word _reset
_undef_vector_h:    .word _undef_vector
_swi_vector_h:      .word _swi_vector
_prefetch_abort_h:  .word _prefetch_abort
_data_abort_h:      .word _data_abort
_unused_h:          .word _unused
_irq_vector_h:      .word _irq_vector
_fiq_vector_h:      .word _fiq_vector

_reset:
    MOV     r0,#0x8000
    MOV     r1,#0x0000
    LDMIA   r0!,{r2,r3,r4,r5,r6,r7,r8,r9}
    STMIA   r1!,{r2,r3,r4,r5,r6,r7,r8,r9}
    LDMIA   r0!,{r2,r3,r4,r5,r6,r7,r8,r9}
    STMIA   r1!,{r2,r3,r4,r5,r6,r7,r8,r9}

    /* Initialize stack pointers for all ARM modes */
    MSR     CPSR_c, #(CPSR_IRQ_MODE | CPSR_IRQ_DISABLE | CPSR_FIQ_DISABLE)
    MOV     sp, #IRQ_STACK_TOP
    
    MSR     CPSR_c, #(CPSR_FIQ_MODE | CPSR_IRQ_DISABLE | CPSR_FIQ_DISABLE)
    MOV     sp, #FIQ_STACK_TOP

    MSR     CPSR_c, #(CPSR_SVC_MODE | CPSR_IRQ_DISABLE | CPSR_FIQ_DISABLE)
    MOV     sp, #SVC_STACK_TOP

    MSR     CPSR_c, #(CPSR_ABT_MODE | CPSR_IRQ_DISABLE | CPSR_FIQ_DISABLE)
    MOV     sp, #ABT_STACK_TOP

    MSR     CPSR_c, #(CPSR_UND_MODE | CPSR_IRQ_DISABLE | CPSR_FIQ_DISABLE)
    MOV     sp, #UND_STACK_TOP
    
    MSR     CPSR_c, #(CPSR_SYS_MODE | CPSR_IRQ_DISABLE | CPSR_FIQ_DISABLE)
    MOV     sp, #SYS_STACK_TOP

    BL cstartup
_hang: B _hang

_undef_vector:
    BL      c_undef_handler
    B _hang

_prefetch_abort:
    BL      c_prefetch_abort
    B _hang

_data_abort:
    BL      c_data_abort
    B _hang

_unused:
    BL      c_unused
    B _hang

_swi_vector:
    PUSH {r0-r12,lr}        /* STMFD   sp!, {r0-r12, lr} */
    LDR     r0, [lr, #-4]
    BIC     r0, r0, #0xff000000
    MOV     r1, sp
    MRS     r2, spsr
    PUSH {r2}               /* STMFD   sp!, {r2} */
    BL      c_swi_handler
    POP {r2}                /* LDMFD   sp!, {r2} */
    MSR     spsr, r2
    LDMFD   sp!, {r0-r12, pc}^

_irq_vector:
    PUSH    {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,lr}
    BL      c_irq_handler
    POP     {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,lr}
    SUBS    pc, lr, #4

_fiq_vector:
    BL      c_fiq_vector
    B _hang

.globl _disable_interrupts
_disable_interrupts:
    /* todo: */
    BX      lr

.globl _enable_interrupts
_enable_interrupts:
    MRS     r0, CPSR
    BIC     r0, r0, #CPSR_IRQ_DISABLE
    MSR     CPSR_c, r0
    BX      lr

.globl _get_stack_pointer
_get_stack_pointer:
    MOV     r0, sp
    MOV     pc, lr

.globl _get_lr
_get_lr:
    MOV     r0, lr
    MOV     pc, lr
    
.globl _get32
_get32:
    LDR     r0, [r0]
    BX      lr

.globl _put32
_put32:
    STR     r1, [r0]
    BX      lr

.globl _context_switch
_context_switch:
    MRS     r12, CPSR       /* r12 is a scratch register and doesnt have to be saved */
    PUSH    {r0-r12, lr}
    
    STR     sp, [r0]        /* put the current sp at location in r0 */
    LDR     sp, [r1]        /* load sp value from location in r1 */
    
    POP     {r0-r12}
    MSR     CPSR_c, r12
    POP     {pc}
