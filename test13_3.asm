section code align=16 vstart=0x7c00
	mov ax, 0xb800
	mov es, ax
	xor di, di
	jmp near _start
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
	
	mov dx, 0x1f0
	mov cx, 3
@display:
	in ax, dx
	mov [es:di], al
	mov byte [es:di+1], 0x7
	mov [es:di+2], ah
	mov byte [es:di+3], 0x7
	add di, 4
	loop @display

	cmp byte [@params+1], 101
	je near _end
	mov byte [@params+1], 101
	jmp near _start
_end:
	jmp near $
	times 510-($-$$) db 0
	db 0x55, 0xaa
