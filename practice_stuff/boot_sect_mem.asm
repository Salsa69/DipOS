[org 0x7c00]
mov ah, 0x0e

; attempt 2
mov al, "2"
int 0x10
mov al, [var]
int 0x10

; attempt 3
mov al, "3"
int 0x10
mov bx, var
add bx, 0x7c00
mov al, [bx]
int 0x10

; attempt 4
mov al, "4"
int 0x10
mov al, [0x7c2d]
int 0x10


jmp $ ; infinite loop

var:
    db "X"

; zero padding and magic bios number
times 510-($-$$) db 0
dw 0xaa55
