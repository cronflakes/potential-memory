

 	org 0x7c00

	mov bx, msg
 	call BIOSprint

 	mov dx, 0x4142
 	call HEXprint

hang:
  	jmp hang

	%include "BIOS/biosprint.s"
	%include "BIOS/hexprint.s"

  	msg db "Something OS", 13, 10, 0
	times 510-($-$$) db 0
 	dw 0xaa55
