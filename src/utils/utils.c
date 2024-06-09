#include <stdint.h>
#include <stddef.h>

#include "utils.h"
#include "terminal.h"

uint32_t strlen(char *s) {
	uint32_t len = 0;
	
	if(s == (void *)0x0)
		return len;

	while(*s) {
		len++;
		s++;
	}

	return len;
}

void print(char *s) {
	uint32_t len = strlen(s);
	terminal_write(s, len);
}

void outportb(uint16_t port, uint8_t value) {
	asm volatile ("outb %1, %0" : : "dN"(port), "a"(value));
}

uint8_t inportb(uint16_t port) {
	uint8_t c;
	asm volatile ("inb %1, %0" : "=a"(c) : "dN"(port));
	return c;
}
