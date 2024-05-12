;exceptions - the first 32 entries in the IDt correspond to exceptions
global isr0 ; divide by zero
isr0: 	
	cli
	push byte 0
	push byte 0
	jmp isr_stub

global isr1 ; debug 
isr1:
	cli 
	push byte 0
	push byte 1
	jmp isr_stub

global isr2 ; non-maskable interrupt 
isr2:
	cli
	push byte 0
	push byte 2
	jmp isr_stub

global isr3 ; int3  
isr3: 
	cli
	push byte 0
	push byte 3
	jmp isr_stub


global isr4 ; INTO 
isr4:
	cli
	push byte 0
	push byte 4
	jmp isr_stub

global isr5 ; out-of-bounds 
isr5:
	cli
	push byte 0
	push byte 5
	jmp isr_stub

global isr6 ; invalid opcode
isr6:
	cli
	push byte 0
	push byte 6
	jmp isr_stub

global isr7 ; no coprocessesor 
isr7:
	cli
	push byte 0
	push byte 7
	jmp isr_stub

global isr8 ; double fault
isr8:
	cli
	push byte 0
	push byte 8
	jmp isr_stub

global isr9 ; coprocessor segment overrun
isr9:
	cli
	push byte 0
	push byte 9
	jmp isr_stub

global isr10 ; bad TSS
isr10:
	cli
	push byte 0
	push byte 10
	jmp isr_stub

global isr11 ; segment not present
isr11:
	cli
	push byte 0
	push byte 11
	jmp isr_stub

global isr12 ; stack fault
isr12:
	cli
	push byte 0
	push byte 12
	jmp isr_stub

global isr13 ; general protection fault
isr13:
	cli
	push byte 0
	push byte 13
	jmp isr_stub

global isr14 ; page fault
isr14:
	cli
	push byte 0
	push byte 14
	jmp isr_stub

global isr15 ; reserved
isr15:
	cli
	push byte 0
	push byte 15
	jmp isr_stub

global isr16 ; floating point
isr16:
	cli
	push byte 0
	push byte 16
	jmp isr_stub

global isr17 ; aligment check
isr17:
	cli
	push byte 0
	push byte 17
	jmp isr_stub

global isr18 ; machine check
isr18:
	cli
	push byte 0
	push byte 18
	jmp isr_stub

global isr19 ; reserved
isr19:
	cli
	push byte 0
	push byte 19
	jmp isr_stub

global isr20 ; reserved
isr20:
	cli
	push byte 0
	push byte 20
	jmp isr_stub

global isr21 ; reserved
isr21:
	cli
	push byte 0
	push byte 21
	jmp isr_stub

global isr22 ; reserved
isr22:
	cli
	push byte 0
	push byte 22
	jmp isr_stub

global isr23 ; reserved
isr23:
	cli
	push byte 0
	push byte 23
	jmp isr_stub

global isr24 ; reserved
isr24:
	cli
	push byte 0
	push byte 24
	jmp isr_stub

global isr25 ; reserved
isr25:
	cli
	push byte 0
	push byte 25
	jmp isr_stub

global isr26 ; reserved
isr26:
	cli
	push byte 0
	push byte 26
	jmp isr_stub


global isr27 ; reserved
isr27:
	cli
	push byte 0
	push byte 27
	jmp isr_stub

global isr28 ; reserved
isr28:
	cli
	push byte 0
	push byte 28
	jmp isr_stub

global isr29 ; reserved
isr29:
	cli
	push byte 0
	push byte 29
	jmp isr_stub

global isr30 ; reserved
isr30:
	cli
	push byte 0
	push byte 30
	jmp isr_stub

global isr31 ; reserved
isr31:
	cli
	push byte 0
	push byte 31
	jmp isr_stub

extern exception_handler

isr_stub:
	pusha
	push ds
	push es
	push fs
	push gs
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov eax, esp
	push eax
	mov eax, exception_handler
	call eax
	pop eax
	pop gs
	pop fs
	pop es
	pop ds
	popa
	add esp, 8
	iret

;interrupts
global irq0
irq0:
	cli
	push byte 0
	push byte 32
	jmp irq_stub

global irq1
irq1:
	cli
	push byte 0
	push byte 33
	jmp irq_stub

global irq2
irq2:
	cli
	push byte 0
	push byte 34
	jmp irq_stub

global irq3
irq3:
	cli
	push byte 0
	push byte 35
	jmp irq_stub

global irq4
irq4:
	cli
	push byte 0
	push byte 36
	jmp irq_stub

global irq5
irq5:
	cli
	push byte 0
	push byte 37
	jmp irq_stub

global irq6
irq6:
	cli
	push byte 0
	push byte 38
	jmp irq_stub

global irq7
irq7:
	cli
	push byte 0
	push byte 39
	jmp irq_stub

global irq8
irq8:
	cli
	push byte 0
	push byte 40
	jmp irq_stub

global irq9
irq9:
	cli
	push byte 0
	push byte 41
	jmp irq_stub

global irq10
irq10:
	cli
	push byte 0
	push byte 42
	jmp irq_stub

global irq11
irq11:
	cli
	push byte 0
	push byte 43
	jmp irq_stub

global irq12
irq12:
	cli
	push byte 0
	push byte 44
	jmp irq_stub

global irq13
irq13:
	cli
	push byte 0
	push byte 45
	jmp irq_stub

global irq14
irq14:
	cli
	push byte 0
	push byte 46
	jmp irq_stub

global irq15
irq15:
	cli
	push byte 0
	push byte 47
	jmp irq_stub

extern irq_handler

irq_stub: 
	pusha
	push ds
	push es
	push fs
	push gs
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov eax, esp
	push eax
	mov eax, irq_handler
	call eax
	pop gs
	pop fs
	pop es
	pop ds
	popa 
	add esp, 8
	iret

;load interrupt table
global set_idt
extern idtr
set_idt:
	lidt [idtr]
	ret

