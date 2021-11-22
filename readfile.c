#include <stdio.h>
#include <stdlib.h>

int main(int argc,char** argv)
{
	if(argc<5)
	{
		printf("Usage: %s <destfile> <sourcefile> <start sector> <size>",argv[0]);
		return -1;
	}
	FILE* dest;
	FILE* source;

	dest = fopen(argv[1],"rb+");
	source = fopen(argv[2],"rb");
	int startSector = atoi(argv[3]);
	int totalSize = atoi(argv[4]);

	int sek_ret = fseek(dest,startSector*512,SEEK_SET);
	if(sek_ret!=0)
	{
		puts("Error");
		return -1;
	}

	int transedSize = 0;
	char buf[512];
	while(1)
	{
		int nowSize = totalSize-transedSize<512?totalSize-transedSize:512;
		if(nowSize<=0)
		{
			break;
		}
		int size_r = fread(buf,1,nowSize,source);
		int w_r = fwrite(buf,1,size_r,dest);
		if(size_r!=nowSize)
		{
			if(feof(source))
			{
				puts("Success");
				break;
			}
			puts("Error1");
			return -1;
		}
		if(w_r!=size_r)
		{
			if(feof(dest))
			{
				puts("encounter dest eof");
				break;
			}
		}
		transedSize+=size_r;
	}
	return 0;
}
