	org 0x7c00

	mov bx, msg
 	call BIOSprint

	; =====================================
	;
	; read next sector and load into memory
	;
	; =====================================

	mov bx, 0x1000
	mov es, bx
	mov bx, 0x0
	mov ch, 0x0		; track/cylinder number
	mov cl, 0x2		; sector number
	mov dh, 0x0		; head number
	mov dl, 0x80		; drive number = 0x80 hard disk 1

diskread:
	mov ah, 0x2		; read disk sector
	mov al, 0x1		; number of sectors to read
	int 0x13		; BIOS storage interrupt
	jc diskread		; CF = 1 if error, retry 

	mov ax, 0x1000
	mov ds, ax
	jmp 0x1000:0x0

	%include "BIOS/biosprint.s"

  	msg db 13, 10, "Loading OS...", 13, 10, 13, 10, 0
	times 510-($-$$) db 0
 	dw 0xaa55
