.global set_gdt
.extern gdtp
.type set_gdt, @function
set_gdt:

	lgdt (gdtp)
	ljmp $0x08, $reload_CS

reload_CS:

	mov $0x10, %ax
	mov %ds, %ax
	mov %es, %ax
	mov %fs, %ax
	mov %gs, %ax
	mov %ss, %ax
	ret
