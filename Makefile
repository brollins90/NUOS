
APP_NAME = kernel7

CC      = arm-none-eabi-gcc
ASM     = arm-none-eabi-as
LINK    = arm-none-eabi-gcc
RM      = rm -f

BINDIR  = bin
OBJDIR  = obj
SRCDIR  = src

LINKER  = $(APP_NAME).ld

ELF     = $(BINDIR)/$(APP_NAME).elf
IMAGE   = $(BINDIR)/$(APP_NAME).img
NM      = $(BINDIR)/$(APP_NAME).nm
LIST    = $(BINDIR)/$(APP_NAME).list

CCINC   = -I$(SRCDIR)/include -I$(SRCDIR)/platform/rpi/include -I$(OBJDIR)

CCFLAGS = -c -O0 -DRPI2 -nostartfiles -o$@

ASMFLAGS = -o$@

LINKFLAGS = -T $(LINKER) -o $(ELF) \
	-Wl,-Map,$(OBJDIR)/$(APP_NAME).map,--cref -lm -nostartfiles

all: $(NM) $(LIST) $(IMAGE)

$(NM) : $(ELF)
	arm-none-eabi-nm $(ELF) > $(NM)

$(LIST) : $(ELF)
	arm-none-eabi-objdump -d $(ELF) > $(LIST)

$(IMAGE) : $(ELF)
	arm-none-eabi-objcopy $(ELF) -O binary $(IMAGE) 
    
$(ELF) : $(BINDIR) \
	./$(LINKER) \
	$(OBJDIR)/start.o \
	$(OBJDIR)/irq.o \
	$(OBJDIR)/swi.o \
	$(OBJDIR)/cstartup.o \
	$(OBJDIR)/create.o \
	$(OBJDIR)/debug-write.o \
	$(OBJDIR)/kernel.o \
	$(OBJDIR)/memory.o \
	$(OBJDIR)/processor.o \
	$(OBJDIR)/scheduler.o \
	$(OBJDIR)/syscall.o \
	$(OBJDIR)/context-switch.o \
	$(OBJDIR)/rpi-armtimer.o \
	$(OBJDIR)/rpi-gpio.o \
	$(OBJDIR)/rpi-irq.o \
	$(OBJDIR)/rpi-uart.o
	$(LINK) \
	$(OBJDIR)/start.o \
	$(OBJDIR)/irq.o \
	$(OBJDIR)/swi.o \
	$(OBJDIR)/cstartup.o \
	$(OBJDIR)/create.o \
	$(OBJDIR)/debug-write.o \
	$(OBJDIR)/kernel.o \
	$(OBJDIR)/memory.o \
	$(OBJDIR)/processor.o \
	$(OBJDIR)/scheduler.o \
	$(OBJDIR)/syscall.o \
	$(OBJDIR)/context-switch.o \
	$(OBJDIR)/rpi-armtimer.o \
	$(OBJDIR)/rpi-gpio.o \
	$(OBJDIR)/rpi-irq.o \
	$(OBJDIR)/rpi-uart.o \
	$(LINKFLAGS)

$(BINDIR): 
	mkdir $(BINDIR)

$(OBJDIR): 
	mkdir $(OBJDIR)

$(OBJDIR)/boot: 
	mkdir $(OBJDIR)/boot

# boot
$(OBJDIR)/start.o: $(SRCDIR)/boot/start.s $(OBJDIR)
	$(ASM) $(ASMFLAGS) $<

$(OBJDIR)/irq.o: $(SRCDIR)/boot/irq.c $(OBJDIR)
	$(CC) $(CCFLAGS) $(CCINC) $<

$(OBJDIR)/swi.o: $(SRCDIR)/boot/swi.c $(OBJDIR)
	$(CC) $(CCFLAGS) $(CCINC) $<

$(OBJDIR)/cstartup.o: $(SRCDIR)/boot/cstartup.c $(OBJDIR)
	$(CC) $(CCFLAGS) $(CCINC) $<


$(OBJDIR)/kernel.o: $(SRCDIR)/kernel/kernel.c $(OBJDIR)
	$(CC) $(CCFLAGS) $(CCINC) $<

$(OBJDIR)/debug-write.o: $(SRCDIR)/kernel/debug-write.c $(OBJDIR)
	$(CC) $(CCFLAGS) $(CCINC) $<

$(OBJDIR)/syscall.o: $(SRCDIR)/kernel/syscall.c $(OBJDIR)
	$(CC) $(CCFLAGS) $(CCINC) $<

# memory
$(OBJDIR)/memory.o: $(SRCDIR)/kernel/memory.c $(OBJDIR)
	$(CC) $(CCFLAGS) $(CCINC) $<

# processor
$(OBJDIR)/create.o: $(SRCDIR)/kernel/create.c $(OBJDIR)
	$(CC) $(CCFLAGS) $(CCINC) $<

$(OBJDIR)/processor.o: $(SRCDIR)/kernel/processor.c $(OBJDIR)
	$(CC) $(CCFLAGS) $(CCINC) $<

$(OBJDIR)/scheduler.o: $(SRCDIR)/kernel/scheduler.c $(OBJDIR)
	$(CC) $(CCFLAGS) $(CCINC) $<

# arm
$(OBJDIR)/context-switch.o: $(SRCDIR)/arch/arm/context-switch.s $(OBJDIR)
	$(ASM) $(ASMFLAGS) $<

# pi
$(OBJDIR)/rpi-armtimer.o: $(SRCDIR)/platform/rpi/rpi-armtimer.c $(OBJDIR)
	$(CC) $(CCFLAGS) $(CCINC) $<
    
$(OBJDIR)/rpi-gpio.o: $(SRCDIR)/platform/rpi/rpi-gpio.c $(OBJDIR)
	$(CC) $(CCFLAGS) $(CCINC) $<

$(OBJDIR)/rpi-irq.o: $(SRCDIR)/platform/rpi/rpi-irq.c $(OBJDIR)
	$(CC) $(CCFLAGS) $(CCINC) $<

$(OBJDIR)/rpi-uart.o: $(SRCDIR)/platform/rpi/rpi-uart.c $(OBJDIR)
	$(CC) $(CCFLAGS) $(CCINC) $<

clean:
	-$(RM) $(BINDIR)/*.*
	-$(RM) $(OBJDIR)/*.*
