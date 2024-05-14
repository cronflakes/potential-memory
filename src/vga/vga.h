#ifndef _VGA_H
#define _VGA_H

#include <stddef.h>

extern size_t VGA_WIDTH;
extern size_t VGA_HEIGHT;

enum vga_color {
	VGA_BLACK   = 0,
	VGA_BLUE    = 1,
	VGA_GREEN   = 2,
	VGA_CYAN    = 3,
	VGA_RED     = 4,
	VGA_MAGENTA = 5,
	VGA_GREY    = 7,
	VGA_WHITE   = 15,
};

extern uint16_t vga_entry_color(enum vga_color,  enum vga_color);
extern uint16_t vga_entry(uint8_t, uint8_t);
#endif
