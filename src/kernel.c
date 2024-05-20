#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include "terminal.h"
#include "gdt.h"
#include "idt.h"
#include "pit.h"
#include "keyboard.h"
#include "utils.h"

void kernel_main(void) {
	terminal_init();
	init_gdt();
	init_idt();
	print("gdt and idt init'd\n");
	init_keyboard();
	//init_pit();

	for(;;);
}
