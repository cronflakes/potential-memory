#ifndef _IDT_H
#define _IDT_H

#define IDT_MAX_DESCRIPTORS 32

typedef struct {
	uint16_t isr_lo;
	uint16_t kernel_cs;
	uint8_t reserved;
	uint8_t attributes;
	uint16_t isr_hi;
} __attribute__((packed)) idt_entry_t;

typedef struct {
	uint16_t limit;
	uint32_t base;
} __attribute((packed)) idtr_t;
	
extern void init_idt();
#endif 
