
.globl _context_switch
_context_switch:
    MRS     r12, CPSR       /* r12 is a scratch register and doesnt have to be saved */
    PUSH    {r0-r12, lr}
    
    STR     sp, [r0]        /* put the current sp at location in r0 */
    LDR     sp, [r1]        /* load sp value from location in r1 */
    
    POP     {r0-r12}
    MSR     CPSR_c, r12
    POP     {pc}
