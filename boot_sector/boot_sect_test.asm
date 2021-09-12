[org 0x7c00]

mov dx, THING
call print_hex

jmp $

%include "boot_sect_print.asm"
%include "boot_sect_print_hex.asm"

;data
THING:
    dw 0x6942

times 510-($-$$) db 0
dw 0xaa55