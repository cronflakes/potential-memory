#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include "terminal/terminal.h"
#include "gdt/gdt.h"
#include "idt/idt.h"
#include "timer/pit.h"

void kernel_main(void) {
	terminal_init();
	init_gdt();
	init_idt();
	terminal_write("gdt and idt init'd\n", 19);

	init_pit();
	terminal_write("gdt and idt init'd again\n", 25);
}
