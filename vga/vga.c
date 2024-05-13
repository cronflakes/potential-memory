#include <stdint.h>

#include "vga.h"

inline uint16_t vga_entry_color(enum vga_color fg, enum vga_color bg) {
	return fg | bg << 4;
}

inline uint16_t vga_entry(uint8_t uc, uint8_t color) {
	return (uint16_t) uc | (uint16_t) color << 8;
}
