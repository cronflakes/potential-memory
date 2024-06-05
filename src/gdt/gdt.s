gdt:
	;NULL descriptor
	dw 0, 0
	db 0, 0, 0, 0

	;kernel code 
	dw 0xffff, 0
	db 0, 0x9a, 0xcf, 0

	;kernel data
	dw 0xffff, 0
	db 0, 0x92, 0xcf, 0
gdtend:

gdtr:
	dw gdtend - gdt - 1
	dd gdt
	
loadgdt:
	cli
	lgdt [gdtr]
	ret

