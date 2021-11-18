section code align=16 vstart=0x7c00
	xor ax, ax
	mov ds, ax
	jmp near @start
@str:	db 'world', 0
@ax:    db 1, 100, 0, 0, 0xe0, 0x30

@start:
	mov dx, 0x1f1           ;扇区
	mov cx, 6
	xor si, si
@param:
	inc dx
	mov al, [@ax+si]
	out dx, al
	inc si
	loop @param
@ready:
	in al, dx
	and al, 0b1000_1000
	cmp al, 0x08
	jnz @ready

	mov cx, 3
	mov dx, 0x1f0
	xor si, si
@t1:
	mov ax, [@str+si]
	out dx, ax
	add si, 2
	loop @t1

	mov cx, 253
	mov ax, 0
@t3:
	out dx, ax
	loop @t3

	jmp near $
	times 510-($-$$) db 0
	db 0x55, 0xaa
