#include <stddef.h>
#include <stdint.h>

#include "idt.h"
#include "../terminal/terminal.h"

static inline void outportb(uint16_t, uint8_t);
static inline uint8_t inportb(uint16_t);

__attribute__((aligned(0x10))) idt_entry_t idt[256];
idtr_t idtr;
regs *r;

char *exception_messages[] = {
	"Division by Zero",
	"Debug"
};

void *irq_routines[16] = {
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0
};

void exception_handler(regs *r) {
	if(r->irq_line == 0) {
		terminal_write("exception occurred\n", 19); 
		__asm__ volatile ("cli; hlt");
	}
}

void idt_set_descriptor(uint8_t vector, uint32_t isr, uint8_t flags) {
	idt_entry_t *descriptor = &idt[vector];

	descriptor->isr_lo = isr & 0xffff;
	descriptor->kernel_cs = 0x08;
	descriptor->attributes = flags;
	descriptor->isr_hi = isr >> 16;
	descriptor->reserved = 0;
}


void irq_install_handler(uint32_t irq, void(*handler)(regs *r)) {
	irq_routines[irq] = handler;
}

void init_idt() {
	idtr.limit = (sizeof(idt_entry_t) * IDT_MAX_DESCRIPTORS) - 1;
	idtr.base = (uint32_t)&idt;

	//remap irq[0-15] to DIT entries [32-47]
	outportb(0x20, 0x11);
	outportb(0xa0, 0x11);
	outportb(0x21, 0x20);
	outportb(0xa1, 0x28);
	outportb(0x21, 0x04);
	outportb(0xa1, 0x02);
	outportb(0x21, 0x01);
	outportb(0xa1, 0x01);
	outportb(0x21, 0x0);
	outportb(0xa1, 0x0);	

	//exceptions
	idt_set_descriptor(0, (uint32_t)isr0, 0x8e);
	idt_set_descriptor(1, (uint32_t)isr1, 0x8e);
	idt_set_descriptor(2, (uint32_t)isr2, 0x8e);
	idt_set_descriptor(3, (uint32_t)isr3, 0x8e);
	idt_set_descriptor(4, (uint32_t)isr4, 0x8e);
	idt_set_descriptor(5, (uint32_t)isr5, 0x8e);
	idt_set_descriptor(6, (uint32_t)isr6, 0x8e);
	idt_set_descriptor(7, (uint32_t)isr7, 0x8e);
	idt_set_descriptor(8, (uint32_t)isr8, 0x8e);
	idt_set_descriptor(9, (uint32_t)isr9, 0x8e);
	idt_set_descriptor(10, (uint32_t)isr10, 0x8e);
	idt_set_descriptor(11, (uint32_t)isr11, 0x8e);
	idt_set_descriptor(12, (uint32_t)isr12, 0x8e);
	idt_set_descriptor(13, (uint32_t)isr13, 0x8e);
	idt_set_descriptor(14, (uint32_t)isr14, 0x8e);
	idt_set_descriptor(15, (uint32_t)isr15, 0x8e);
	idt_set_descriptor(16, (uint32_t)isr16, 0x8e);
	idt_set_descriptor(17, (uint32_t)isr17, 0x8e);
	idt_set_descriptor(18, (uint32_t)isr18, 0x8e);
	idt_set_descriptor(19, (uint32_t)isr19, 0x8e);
	idt_set_descriptor(20, (uint32_t)isr20, 0x8e);
	idt_set_descriptor(21, (uint32_t)isr21, 0x8e);
	idt_set_descriptor(22, (uint32_t)isr22, 0x8e);
	idt_set_descriptor(23, (uint32_t)isr23, 0x8e);
	idt_set_descriptor(24, (uint32_t)isr24, 0x8e);
	idt_set_descriptor(25, (uint32_t)isr25, 0x8e);
	idt_set_descriptor(26, (uint32_t)isr26, 0x8e);
	idt_set_descriptor(27, (uint32_t)isr27, 0x8e);
	idt_set_descriptor(28, (uint32_t)isr28, 0x8e);
	idt_set_descriptor(29, (uint32_t)isr29, 0x8e);
	idt_set_descriptor(30, (uint32_t)isr30, 0x8e);
	idt_set_descriptor(31, (uint32_t)isr31, 0x8e);

	//interrupts
	idt_set_descriptor(32, (uint32_t)irq0, 0x8e);
	idt_set_descriptor(33, (uint32_t)irq1, 0x8e);
	idt_set_descriptor(34, (uint32_t)irq2, 0x8e);
	idt_set_descriptor(35, (uint32_t)irq3, 0x8e);
	idt_set_descriptor(36, (uint32_t)irq4, 0x8e);
	idt_set_descriptor(37, (uint32_t)irq5, 0x8e);
	idt_set_descriptor(38, (uint32_t)irq6, 0x8e);
	idt_set_descriptor(39, (uint32_t)irq7, 0x8e);
	idt_set_descriptor(40, (uint32_t)irq8, 0x8e);
	idt_set_descriptor(41, (uint32_t)irq9, 0x8e);
	idt_set_descriptor(42, (uint32_t)irq10, 0x8e);
	idt_set_descriptor(43, (uint32_t)irq11, 0x8e);
	idt_set_descriptor(44, (uint32_t)irq12, 0x8e);
	idt_set_descriptor(45, (uint32_t)irq13, 0x8e);
	idt_set_descriptor(46, (uint32_t)irq14, 0x8e);
	idt_set_descriptor(47, (uint32_t)irq15, 0x8e);

	set_idt();
}

void irq_handler(regs *r) {
	void (*handler)(regs *r);
	handler = irq_routines[r->irq_line - 32];
	if(handler)
		handler(r);

	if(r->irq_line >= 40)
		outportb(0xa0, 0x20);

	outportb(0x20, 0x20);	
}


static inline void outportb(uint16_t port, uint8_t value) {
	asm volatile ("outb %1, %0" : : "dN"(port), "a"(value));
}

static inline uint8_t inportb(uint16_t port) {
	uint8_t c;
	asm volatile ("inb %1, %0" : "=a"(c) : "dN"(port));
	return c;
}

