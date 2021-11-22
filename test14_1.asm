section code align=16 vstart=0x7c00
	mov ax, 0xb800
	mov es, ax
	xor di, di
	jmp near _start
@memory:    dw 0
@params:	db 1, 100, 0, 0, 0xe0, 0x20

_start:
	mov cx, 6
	xor si, si
	mov dx, 0x1f1
@setparams:
	inc dx
	mov al, [@params+si]
	inc si
	out dx, al
	loop @setparams

@waits:
	in al, dx
	and al, 0b1000_1000
	cmp al, 0x08
	jnz @waits
	
@getPointerPosition: ;获取光标位置的值
	mov dx, 0x3d4
	mov al, 0x0e
	out dx, al
	mov dx, 0x3d5
	in al, dx
	mov ah, al

	mov dx, 0x3d4
	dec al
	out dx, al
	mov dx, 0x3d5
	in al, dx
	add ax, 200
	sal ax, 1
	mov di, ax
	mov [@memory], al
	mov [@memory+1], ah
	
	mov dx, 0x3d4
	mov ax, 0x0f
	out dx, ax
	mov dx, 0x3d5
	mov al, [@memory]
	out dx, al

	mov dx, 0x3d4
	mov ax, 0x0e
	out dx, ax
	mov dx, 0x3d5
	mov al, [@memory+1]
	out dx, al
	
	mov dx, 0x1f0
	mov cx, 10
@display:
	in ax, dx
	mov [es:di], al
	mov byte [es:di+1], 0x7
	mov [es:di+2], ah
	mov byte [es:di+3], 0x7
	add di, 4
	loop @display

	jmp near $
	times 510-($-$$) db 0
	db 0x55, 0xaa
