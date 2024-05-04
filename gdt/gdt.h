#ifndef _GDT_H
#define _GDT_H

#define SEGMENTS 3

struct gdt_entry {
	uint16_t limit_lo;
	uint16_t base_lo;
	uint8_t base_mid;
	uint8_t access;
	uint8_t flags;
	uint8_t base_hi;
} __attribute__((packed));

struct gdt_ptr {
	uint16_t limit;
	uint32_t base;
} __attribute__((packed));

struct gdt_entry gdt[SEGMENTS];
struct gdt_ptr *gdtp;

extern void init_gdt();
#endif
