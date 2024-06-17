	mov ah, 0xe
	mov bx, msg
	call BIOSprint
	
	; =================================
	;
	; main menu	
	;
	; =================================

	mov bx, menu
	call BIOSprint

	mov bx, shell
	call BIOSprint

	xor bx, bx
	xor si, si

prompt:
	xor ax, ax
	int 0x16

	cmp al, 0xd
	jz choice
	mov bx, input
	mov [bx], al	
	mov [si], al
	call BIOSprint

choice:
	mov al, [si]
	cmp al, "2"
	jz reboot
	cmp al, "1"
	jne prompt

	; =================================
	;
	; read 3rd sector into memory
	;
	; =================================

	mov bx, 0x2000
	mov es, bx
	mov bx, 0x0
	mov ch, 0x0
	mov cl, 0x3
	mov dh, 0x0
	mov dl, 0x80

;readkernel:
	;xor bx, bx
	;mov ah, 0x2
	;mov al, 0x9
	;int 0x13
	;jc readkernel

	; =================================
	; 
	; load temporary GDT
	; 	
	; =================================
	
	cli
	xor ax, ax
	mov ds, ax
	lgdt [gdtr]

	; =================================
	; 
	; change into protected mode
	; 	
	; =================================

	mov eax, cr0
	or eax, 0x1
	mov cr0, eax
	jmp 0x8:loadkernel

loadkernel:
	mov ax, 0x10
	mov ds, ax
	mov ss, ax
	mov esp, 0xffff
	;sti	

hang:
	jmp hang

reboot:
	int 0x19

	%include "BIOS/biosprint.s"
	%include "gdt/gdt.s"

  	msg db "==========================", 13, 10, 32, 32, 32, 32, 32, 32, 32, "Something OS", 13, 10, "==========================", 13, 10, 0
	menu db  13, 10, 32, 32, 32, 32, 32, 32, 32, "1 - shell", 13, 10, 32, 32, 32, 32, 32, 32, 32, "2 - reboot", 13, 10, 0
	shell db 13, 10, 32, 32, 'sh-$', 32, 0
	input db " " 13, 10, 13, 10, 0
	debug db "DEBUG", 0

	times 512-($-$$) db 0	
