#include <stdint.h>

#include "../vga/vga.h"

size_t VGA_WIDTH = 80;
size_t VGA_HEIGHT = 25;

size_t terminal_row;
size_t terminal_col;
uint8_t terminal_color;
uint16_t *terminal_buffer;

void clear(void) {
	for(uint8_t y = 0; y < VGA_HEIGHT; y++) {
		for(uint8_t x = 0; x < VGA_WIDTH; x++) {
			const uint8_t index = y * VGA_WIDTH + x;
			terminal_buffer[index] = vga_entry(' ', terminal_color);
		}
	}

	terminal_row = 0;
	terminal_col = 0;
}

void terminal_init(void) {
	terminal_row = 0;
	terminal_col = 0;
	
	terminal_color = vga_entry_color(VGA_GREEN, VGA_BLACK);
	terminal_buffer = (uint16_t *)0xb8000;
	
	clear();
}

static void terminal_putentryat(uint8_t c, uint8_t color, size_t x, size_t y) {
	const size_t index = y * VGA_WIDTH + x;
	terminal_buffer[index] = vga_entry(c, color);
}

static void terminal_putchar(char c) {
	if(c == '\n') {
		terminal_col = 0;
		terminal_row++;
		return;
	} 

	terminal_putentryat(c, terminal_color, terminal_col, terminal_row);
	if(++terminal_col == VGA_WIDTH) {
		terminal_col = 0;
		if(++terminal_row == VGA_HEIGHT) 
			terminal_row = 0;
	}
}

void terminal_write(const char *data, size_t len) {
	for(size_t i = 0; i < len; i++)
		terminal_putchar(data[i]);
}	
