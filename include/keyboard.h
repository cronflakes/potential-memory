#ifndef _KEYBOARD_H
#define _KEYBOARD_H

//US keyboard layout 	
uint8_t char keymap[128] = {
	0, 27, '1', '2', '3', '4', '5', '6', '7', '8',
	'9', '0', '-', '=', '\b', '\t', 'q', 'w', 'e', 'r',
	't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n', 'm',
	',', '.', '/', 0, '*', 0, ' ',
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	'-', 0, 0, 0, '+', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
};

void keyboard_handler(regs *r);
void init_keyboard(void);
#endif
