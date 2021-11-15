    mov ax, 0xb800
    mov ds, ax

    mov cx, 0
    mov di, 0
	call clear ;清屏
	mov di, 0
	;在这里开始写代码-------
	


	;--------end------------
clear:
    mov byte [di], ' '
    mov byte [di+1], 0x7
    add di, 2
    inc cx
    cmp cx, 2000
    js clear
	ret
lp_:jmp lp_
    times 510-($-$$) db 0
    db 0x55, 0xaa
