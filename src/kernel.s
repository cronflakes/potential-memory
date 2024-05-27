	mov ah, 0xe
	mov bx, msg
	call BIOSprint
	
hang:
	jmp hang	

	%include "BIOS/biosprint.s"

  	msg db "Something OS", 13, 10, 0
