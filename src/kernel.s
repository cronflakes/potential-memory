	mov ah, 0xe
	mov bx, msg
	call BIOSprint

	mov bx, menu
	call BIOSprint

	mov bx, prompt
	call BIOSprint
	
	;menu prompt
	xor ax, ax
	int 0x16

	cmp al, "2"
	jz reboot
	
hang:
	jmp hang	

reboot:
	int 0x19

	%include "BIOS/biosprint.s"

  	msg db "==========================", 13, 10, 32, 32, 32, 32, 32, 32, 32, "Something OS", 13, 10, "==========================", 13, 10, 0
	menu db  13, 10, 32, 32, 32, 32, 32, 32, 32, "1 - shell", 13, 10, 32, 32, 32, 32, 32, 32, 32, "2 - reboot", 13, 10, 0
	prompt db 13, 10, 32, 32, 'sh-$', 32, 0
