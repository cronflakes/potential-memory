global set_gdt
extern gdtp
set_gdt:
	lgdt [gdtp]
	push 0x10
	pop ds
	push 0x10
	pop es
	push 0x10
	pop fs
	push 0x10
	pop gs 
	push 0x10
	pop ss
	jmp  0x08:.reload_CS

.reload_CS:
	ret
