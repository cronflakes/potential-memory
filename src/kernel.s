	mov ah, 0xe
	mov bx, msg
	call BIOSprint

	mov bx, menu
	call BIOSprint

	mov bx, shell
	call BIOSprint

	;main menu	
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

readkernel:
	cmp al, "1"
	jne prompt

	mov ah, 0x3
	mov al, ;how many sectors?
	int 0x13
	jc readkernel

	call loadgdt

	;change into protected mode
	mov eax, cr0
	or eax, 0x1
	mov cr0, eax

	mov ax, 0x10
	mov dx, ax
	jmp 0x8:loadkernel
	
loadkernel:
	bits 32
	;map 3rd disk sector to 2nd MiB of memory
	mov bx, 0x2000
	mov es, bx
	mov bx, 0x0
	mov ch, 0x0
	mov cl, 0x3
	mov dh, 0x0
	mov dl, 0x80		

reboot:
	int 0x19

	%include "BIOS/biosprint.s"
	%include "gdt/gdt.s"

  	msg db "==========================", 13, 10, 32, 32, 32, 32, 32, 32, 32, "Something OS", 13, 10, "==========================", 13, 10, 0
	menu db  13, 10, 32, 32, 32, 32, 32, 32, 32, "1 - shell", 13, 10, 32, 32, 32, 32, 32, 32, 32, "2 - reboot", 13, 10, 0
	shell db 13, 10, 32, 32, 'sh-$', 32, 0
	input db " " 13, 10, 13, 10, 0
