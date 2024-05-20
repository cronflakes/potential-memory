#include <stdint.h>

#include "keyboard.h"
#include "idt.h"
#include "terminal.h"
#include "utils.h"

const uint8_t keymap[128] = {
	0, 27, '1', '2', '3', '4', '5', '6', '7', '8',
	'9', '0', '-', '=', '\b', '\t', 'q', 'w', 'e', 'r',
	't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n', 0,
	'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';',
	'\'', '`', 0, '\\', 'z', 'x', 'c', 'v', 'b', 'n', 
	'm', ',', '.', '/', 0, '*', 0, ' ', 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '-', 0, 0, 0, '+', 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
};

void keyboard_handler(regs *r) {
	uint8_t scancode = inportb(0x60);

	//if(!(scancode & 0x80))
	terminal_putchar(keymap[scancode]);
	
}

void init_keyboard(void) {
	irq_install_handler(1, keyboard_handler);
}

