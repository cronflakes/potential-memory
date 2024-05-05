CC = ${HOME}/bin/i686-elf-gcc
CFLAGS = -ffreestanding -std=gnu99 -O2 -Wall -Wextra

all: boot kernel 

clean:
	rm -rf *.o tiny.*

boot: 
	nasm -f elf32 boot.s -o boot.o
	nasm -f elf32 gdt/gdt.s -o gdts.o
	nasm -f elf32 idt/idt.s -o idts.o
	
kernel: 
	$(CC) -g -c kernel.c -o kernel.o $(CFLAGS)
	$(CC) -g -c gdt/gdt.c -o gdt.o $(CFLAGS)
	$(CC) -g -c idt/idt.c -o idt.o $(CFLAGS)

# i686-elf-gcc -T linker.ld -o tiny.bin -ffreestanding -O2 -nostdlib boot.o kernel.o gdt.o gdts.o \
	       idt.o idts.o -lgcc 

