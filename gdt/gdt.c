#include <stdint.h>

#include "gdt.h"

void init_gdt(void);
void add_gdt_entry(int8_t, uint32_t, uint32_t, uint8_t, uint8_t);

struct gdt_entry gdt[SEGMENTS];
struct gdt_ptr gdtp;

void init_gdt() {
	gdtp.limit = (sizeof(struct gdt_entry) * 3) - 1;
	gdtp.base = (uint32_t)&gdt;

	add_gdt_entry(0, 0, 0, 0, 0);
	add_gdt_entry(1, 0, 0xffffffff, 0x9a, 0xcf);
	add_gdt_entry(2, 0, 0xffffffff, 0x92, 0xcf);

	set_gdt();
	
}

void add_gdt_entry(int8_t index, uint32_t base, uint32_t limit, uint8_t access, uint8_t flags) {
	gdt[index].base_lo = base & 0xffff;
	gdt[index].base_mid = (base >> 16) & 0xff;
	gdt[index].base_hi = (base >> 24) & 0xff;

	gdt[index].limit_lo = limit & 0xffff;
	gdt[index].access = access;

	//flags w/limit 
	gdt[index].flags = (limit >> 16) & 0x0f;
	gdt[index].flags |= flags & 0xf0;
}
	
	
	
