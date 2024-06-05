#include "terminal.h"
#include "gdt.h"
#include "utils.h"

void kmain(void) {
	terminal_init();
	init_gdt();
	print("gdt has been init'd\n");
}
