#include <stdint.h>

#include "../../idt/idt.h";
#include "../../terminal/terminal.h";

void keyboard_handler(regs *r) {
	uint8_t scancode = inportb(0x60);

	//key released	
	if(scancode & 0x80)
	
	//key pressed
	else
		terminal_putchar(keymap[scancode]);
}

void init_keyboard(void) {
	irq_install_handler(1, keyboard_handler);
}



