#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include "terminal/terminal.h"
#include "gdt/gdt.h"
#include "idt/idt.h"

void kernel_main(void) {
	int x = 5;
	int y = 0;
	int z;
	terminal_init();
	init_gdt();
	init_idt();
	terminal_write("gdt and idt init'd\n", 19);

	z = x / y;
	if(z > x) 
		terminal_write("junk\n", 5);
	terminal_write("I shouldn't be here\n", 20);

}
