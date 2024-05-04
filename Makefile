CC = ${HOME}/bin/i686-elf-gcc
AS = ${HOME}/bin/i686-elf-as 
CFLAGS = -ffreestanding -std=gnu99 -O2 -Wall -Wextra

clean:
	rm -rf *.o

boot: 
	$(AS) boot.s -o boot.o
	$(AS) gdt/gdt.s -o gdts.o

kernel: 
	$(CC) -g -c kernel.c -o kernel.o $(CFLAGS)
	$(CC) -g -c gdt/gdt.c -o gdt.o $(CFLAGS)

iso:
	$(CC) -T linker.ld -o tiny.bin -ffreestanding -O2 -nostdlib boot.o kernel.o gdt.o gdts.o -lgcc

# i686-elf-gcc -T linked.ld -o myos.bin -ffreestanding -O2 -nosdtlib boot.o kernel.o -lgcc
