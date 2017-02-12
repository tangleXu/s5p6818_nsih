CROSS_COMPILE ?=
ifeq ($(V), 1)
Q			:=
else
Q			:=	@
endif
all:
	$(Q)$(CROSS_COMPILE)gcc -c nsih.S -o nsih.o
	$(Q)$(CROSS_COMPILE)ld -Ttext=0x0 nsih.o -o nsih.elf
	$(Q)$(CROSS_COMPILE)objcopy -Obinary nsih.elf nsih.bin
	$(Q)$(CROSS_COMPILE)objdump -h -d -S nsih.elf > nsih.lst

clean:
	rm -f *.o *.elf *.bin *.lst
