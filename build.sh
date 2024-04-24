#!/bin/bash

if grub-file --is-x86-multioboot tiny.bin; then
	echo multiboot confirmed
else 
	echo file is not multiboot
	return 1
fi


rm tiny.iso
rm -rf iso/
mkdir -p iso/boot/grub
cp -v tiny.bin iso/boot/tiny.bin

echo 'menuentry "tiny" {
	multiboot /boot/tiny.bin
}' > grub.cfg

cp -v grub.cfg iso/boot/grub/

grub-mkrescue -o tiny.iso iso 

