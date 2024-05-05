#include <stdint.h>

#include "idt.h"

void exception_handler(void) {
	__asm__ volatile ("cli; hlt");
}

idt_entry_t idt[256];
idtr_t *idtr;

void idt_set_descriptor(uint8_t vector, void *isr, uint8_t flags) {
	idt_entry_t *descriptor = &idt[vector];

	descriptor->isr_lo = (uint32_t)isr & 0xffff;
	descriptor->kernel_cs = 0x08;
	descriptor->attributes = flags;
	descriptor->isr_hi = (int32_t)isr >> 16;
	descriptor->reserved = 0;
}

extern void *isr_stub_table[];

void init_idt() {
	idtr->limit = (sizeof(idt_entry_t) * IDT_MAX_DESCRIPTORS) - 1;
	idtr->base = (uint32_t)&idt;

	for(uint8_t i = 0; i < 32; i++) {
		idt_set_descriptor(i, isr_stub_table[i], 0x8e);
	}

	__asm__ volatile ("lidt %0" : : "m"(*idtr));		
	__asm__ volatile ("sti");
}

