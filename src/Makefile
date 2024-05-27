CC = ${HOME}/bin/i686-elf-gcc
AS = nasm
CFLAGS = -I../include -ffreestanding -std=gnu99 -O0 -Wall -Wextra
OBJ = boot.o kernel.o gdt.o gdts.o idt.o idts.o vga.o terminal.o pit.o utils.o \
      keyboard.o

all: boot 

clean: rm -f *.bin

boot:
	$(AS) -f bin BIOS/boot.s -o boot.bin


#iso: 	$(OBJ)
#	ld -m elf_i386 -T linker.ld -o tiny.bin -O2 -nostdlib $(OBJ) 

