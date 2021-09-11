; e9 fd ff
loop:
	jmp loop

; 510 zeros - size of previous code
times 510-($-$$) db 0

; Allows bios to recognize sector as boot
dw 0xaa55
