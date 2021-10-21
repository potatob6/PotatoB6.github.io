dd if=/dev/zero of=myhd.img bs=512 count=10240
nasm -f bin a.asm -o a.bin
dd if=a.bin of=myhd.img bs=512 count=1 conv=notrunc
bochs -f mybochsrc
