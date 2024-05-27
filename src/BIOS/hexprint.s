HEXprint:
	  pusha
	  mov cx, 0x4
	  mov bx, HEXstring + 0x5

HEXloop:
	  or cx, cx
	  jz HEXloopend
	  mov ax, dx
	  and ax, 0xf
	  cmp ax, 0xa
	  jge HEXloopascii

	  add al, 0x30
	  jmp HEXloopput

HEXloopascii:
	  add al, 0x37
	  jmp HEXloopput

HEXloopput:
	  mov [bx], al
	  sub cx, 0x1
	  shr dx, 0x4
	  sub bx, 0x1
	  jmp HEXloop

HEXloopend:
	  mov bx, HEXstring
	  call BIOSprint

	  HEXstring db '0x0000', 0
