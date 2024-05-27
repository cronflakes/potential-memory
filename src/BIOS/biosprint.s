BIOSprint:
	  pusha
	  mov ah, 0xe    	; display char

BIOSloop:
	  mov al, [bx]
	  or al, al
	  jz BIOSdone
	  int 0x10      	; BIOS video display interrupt
	  inc bx
	  jmp BIOSloop

BIOSdone:
	  popa
	  ret
