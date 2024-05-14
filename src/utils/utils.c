#include <stdint.h>
#include "utils.h"

void outportb(uint16_t port, uint8_t value) {
	asm volatile ("outb %1, %0" : : "dN"(port), "a"(value));
}

uint8_t inportb(uint16_t port) {
	uint8_t c;
	asm volatile ("inb %1, %0" : "=a"(c) : "dN"(port));
	return c;
}
