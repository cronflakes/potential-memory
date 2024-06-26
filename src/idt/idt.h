#ifndef _INTERRUPTS_H
#define _INTERRUPTS_H

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

typedef struct {
	uint32_t gs, fs, es, ds;
	uint32_t edi, esi, ebp, esp, ebx, edx, ecx, eax;
	uint32_t irq_line, error_code;
	uint32_t eip, cs, eflags, useresp, ss;
} regs;
	
extern void init_idt(void);
extern void init_irq(void);
extern void set_idt(void);
extern void irq_install_handler(uint32_t, void(*handler)(regs *));

extern void irq_handler(regs *);

extern void isr0();
extern void isr1();
extern void isr2();
extern void isr3();
extern void isr4();
extern void isr5();
extern void isr6();
extern void isr7();
extern void isr8();
extern void isr9();
extern void isr10();
extern void isr11();
extern void isr12();
extern void isr13();
extern void isr14();
extern void isr15();
extern void isr16();
extern void isr17();
extern void isr18();
extern void isr19();
extern void isr20();
extern void isr21();
extern void isr22();
extern void isr23();
extern void isr24();
extern void isr25();
extern void isr26();
extern void isr27();
extern void isr28();
extern void isr29();
extern void isr30();
extern void isr31();

extern void irq0();
extern void irq1();
extern void irq2();
extern void irq3();
extern void irq4();
extern void irq5();
extern void irq6();
extern void irq7();
extern void irq8();
extern void irq9();
extern void irq10();
extern void irq11();
extern void irq12();
extern void irq13();
extern void irq14();
extern void irq15();
#endif 
