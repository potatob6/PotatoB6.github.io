if [ ! -f "mybochsrc" ]; then
    wget https://potatob666.github.io/mybochsrc
fi

if [ ! -f "a.asm" ]; then
    wget https://potatob666.github.io/a.asm
fi
dd if=/dev/zero of=myhd.img bs=512 count=10240
nasm -f bin a.asm -o a.bin
if [ ! $? ]; then
    echo "nasm出现错误"
    exit 1
fi
dd if=a.bin of=myhd.img bs=512 count=1 conv=notrunc
if [ $# -lt 1 ]; then
	bochs -f mybochsrc
else
	echo "compile and no run"
fi
