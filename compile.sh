if [ ! -f "mybochsrc" ]; then
    wget https://potatob6.github.io/mybochsrc
fi

if [ ! -f "a.asm" ]; then
    wget https://potatob6.github.io/a.asm
fi

if [[ ! (-e "readfile-armv7l" || -e "readfile-x86_64" ) ]]; then
	arch=$(uname -a|cut -f 13 -d ' ')
	echo $arch
	if [ $arch == "armv7l" ]; then
		wget https://potatob6.github.io/readfile-armv7l
	fi
	if [ $arch == "x86_64" ]; then
		wget https://potatob6.github.io/readfile-x86_64
	fi
	chmod +x readfile-$arch
fi
chmod +x $0
firstBin="a.bin"
paramCounts=$#
onlyCompile=0
fileCounts=0
if [ $paramCounts -gt 0 ]; then
	for i in $(seq $paramCounts):
	do
		filename="a"
		fullFileName="a.asm"

		if [ $1 == "-c" ]; then
			onlyCompile=1
		elif [ $1 == "-h" ]; then
			echo "Usage: $0 [fileName] [option]"
			echo "        options:"
			echo "              -c: only compile"
			echo "              -h: show this hints"
			echo ""
			echo "        [+]Use a.asm as file name If there is no file indicated."
			echo "        [+]Write first input file if there are more than 1 files."
			exit 0
		else
			fileCounts=$((fileCounts+1))
			fullFileName=$1
			filename=$(echo $fullFileName|cut -f 1 -d '.')
			if [ $fileCounts -eq 1 ]; then
				firstBin=$filename.bin
			fi
			
			nasm -f bin $fullFileName -o $filename.bin
			if [ $? != "0" ]; then
				echo " ↑ nasm file $fullFileName encounter a error ↑ "
				exit 1
			fi
		fi
		shift
	done
fi
dd if=/dev/zero of=myhd.img bs=512 count=10240
if [ $fileCounts -eq 0 ]; then
	nasm -f bin a.asm -o a.bin
	if [ $? != "0" ]; then
		echo " ↑ nasm file a.asm encounter a error ↑ "
		exit 1
	fi
fi
dd if=$firstBin of=myhd.img bs=512 count=1 conv=notrunc
echo "[Compile.sh] Writed $firstBin to myhd.img"
if [ $onlyCompile -eq 0 ]; then
	bochs -f mybochsrc
else
	echo "compile and no run"
fi
