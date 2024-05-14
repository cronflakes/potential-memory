MBOOTALIGN 	equ 1 << 0
MEMINFO 	equ 1<<1
FLAGS 		equ MBOOTALIGN | MEMINFO
MAGIC		equ 0x1badb002
CHECKSUM	equ -(MAGIC + FLAGS)

section .multiboot
ALIGN 4
	dd MAGIC
	dd FLAGS
	dd CHECKSUM

section .bss
ALIGN 16
stack_bottom:
	resb 16384
stack_top:

section .text
global _start
_start:
	mov esp, stack_top
	extern kernel_main
	call kernel_main

halt:
	hlt
	jmp halt





