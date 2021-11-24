if [ ! -f "mybochsrc" ]; then
    wget https://potatob666.github.io/mybochsrc
fi

if [ ! -f "a.asm" ]; then
    wget https://potatob666.github.io/a.asm
fi

if [[ ! (-e "readfile-armv7l" || -e "readfile-x86_64" ) ]]; then
	arch=$(uname -a|cut -f 12 -d ' ')
	echo $arch
	if [ $arch == "armv7l" ]; then
		wget https://potatob666.github.io/readfile-armv7l
	fi
	if [ $arch == "x86_64" ]; then
		wget https://potatob666.github.io/readfile-x86_64
	fi
	chmod +x readfile-$arch
fi
chmod +x $0
filename="a"
paramCounts=$#
fullFileName="a.asm"
onlyCompile=0
for i in $(seq $paramCounts):
do
	if [ $1 == "-c" ]; then
		onlyCompile=1
	elif [ $1 == "-h" ]; then
		echo "Usage: $0 [fileName] [option]"
		echo "        options:"
		echo "              -c: only compile"
		echo "              -h: show this hints"
		echo ""
		echo "        Using a.asm as file name If there is no file indicated."
		exit 0
	else
		fullFileName=$1
		filename=$(echo $fullFileName|cut -f 1 -d '.')
	fi
	shift
done
echo "Full name is $fullFileName"
echo "File name is $filename"
dd if=/dev/zero of=myhd.img bs=512 count=10240
nasm -f bin $fullFileName -o $filename.bin
if [ $? != "0" ]; then
    echo "nasm encounter a error"
    exit 1
fi
dd if=a.bin of=myhd.img bs=512 count=1 conv=notrunc
if [ $onlyCompile -eq 0 ]; then
	bochs -f mybochsrc
else
	echo "compile and no run"
fi
