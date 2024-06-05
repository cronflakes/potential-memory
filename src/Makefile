CC = ${HOME}/bin/i686-elf-gcc
AS = /usr/bin/nasm
LD = /usr/bin/ld
CFLAGS = -I../include -ffreestanding -std=gnu99 -O0 -Wall -Wextra
OBJ = gdt.o vga.o terminal.o pit.o utils.o 

all: boot kernel link

clean: 
	rm -f *.bin *.o

boot:
	$(AS) -g -f bin boot.s -o boot.o
	$(AS) -g -f bin kernel.s -o kernel.o

	/usr/bin/cat boot.o kernel.o > tiny.bin

kernel:
	$(CC) -g -c kmain.c -o kmain.o $(CFLAGS)
	$(CC) -g -c gdt/gdt.c -o gdt.o $(CFLAGS)
	$(CC) -g -c vga/vga.c -o vga.o $(CFLAGS)
	$(CC) -g -c terminal/terminal.c -o terminal.o $(CFLAGS)
	$(CC) -g -c utils/utils.c -o utils.o $(CFLAGS)


link: 	$(OBJ)
	$(LD) -o kernel.bin -Ttext 0x2000 $(OBJ) --oformat binary
	
	/usr/bin/cat tiny.bin kernel.bin > something.bin



