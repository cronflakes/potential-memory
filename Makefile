CC = ${HOME}/bin/i686-elf-gcc
CFLAGS = -ffreestanding -std=gnu99 -O0 -Wall -Wextra
OBJ = boot.o kernel.o gdt.o gdts.o idt.o idts.o vga.o terminal.o pit.o utils.o

all: boot kernel iso

clean:
	rm -rf *.o tiny.* iso/

boot: 
	nasm -f elf32 boot.s -o boot.o
	nasm -f elf32 gdt/gdt.s -o gdts.o
	nasm -f elf32 idt/idt.s -o idts.o
	
kernel: 
	$(CC) -g -c kernel.c -o kernel.o $(CFLAGS)
	$(CC) -g -c gdt/gdt.c -o gdt.o $(CFLAGS)
	$(CC) -g -c idt/idt.c -o idt.o $(CFLAGS)
	$(CC) -g -c vga/vga.c -o vga.o $(CFLAGS)
	$(CC) -g -c terminal/terminal.c -o terminal.o $(CFLAGS)
	$(CC) -g -c utils/utils.c -o utils.o $(CFLAGS)
	$(CC) -g -c timer/pit.c -o pit.o $(CFLAGS)

iso: 	$(OBJ)
	ld -m elf_i386 -T linker.ld -o tiny.bin -O2 -nostdlib $(OBJ) 
