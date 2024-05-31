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
	
hang:
	jmp hang	

reboot:
	int 0x19

	%include "BIOS/biosprint.s"

  	msg db "==========================", 13, 10, 32, 32, 32, 32, 32, 32, 32, "Something OS", 13, 10, "==========================", 13, 10, 0
	menu db  13, 10, 32, 32, 32, 32, 32, 32, 32, "1 - shell", 13, 10, 32, 32, 32, 32, 32, 32, 32, "2 - reboot", 13, 10, 0
	shell db 13, 10, 32, 32, 'sh-$', 32, 0
	input db " " 13, 10, 13, 10, 0
