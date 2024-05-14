#include <stdint.h>
#include <stddef.h>

#include "idt.h"
#include "terminal.h"
#include "utils.h"

uint32_t ticks;

void timer_handler() {
	ticks++;
	
	if(ticks % 18 == 0) 
		terminal_write("one second has passed\n", 23);
}

void init_pit() {
	ticks = 0;
	irq_install_handler(0, timer_handler);

	uint32_t divisor = 1193180 / 100;
	outportb(0x43, 0x36);
	outportb(0x40, divisor & 0xff);
	outportb(0x40, divisor >> 8);
}
