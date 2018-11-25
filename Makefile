all : floppy

pong :
	nasm -f bin -o pong.bin pong.asm

floppy : pong
	dd if=/dev/zero of=floppy.img bs=1024 count=1440
	dd if=pong.bin of=floppy.img seek=0 count=1 conv=notrunc

clean :
	rm *.img
	rm *.bin
