[org 0x7c00]
KERNEL_OFFSET equ 0x1000 ; offset when linking kernel

    mov [BOOT_DRIVE], dl ; BIOS puts boot drive in dl
    mov bp, 0x9000
    mov sp, bp

    mov bx, MSG_REAL_MODE ; "Started in 16-bit Real Mode"
    call print
    call print_nl

    call load_kernel ; read the kernel from disk
    call switch_to_pm ; disable interrupts & load GDT
    jmp $

%include "../boot_sector/utils/boot_sect_print.asm"
%include "../boot_sector/utils/boot_sect_print_hex.asm"
%include "../boot_sector/boot_sect_disk.asm"
%include "../32bit/32bit-gdt.asm"
%include "../32bit/32bit-print.asm"
%include "../32bit/32bit-switch.asm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL ; "Loading kernel into memory"
    call print
    call print_nl

    mov bx, KERNEL_OFFSET ; Read from disk and store in 0x1000
    mov dh, 2
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE ; "Now in 32-bit Protected Mode"
    call print_string_pm
    call KERNEL_OFFSET ; Give control to the kernel
    jmp $


BOOT_DRIVE db 0 ; dl might get overwritten
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE db " Now in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0

times 510 - ($-$$) db 0
dw 0xaa55
