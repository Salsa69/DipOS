[bits 32]
[extern main]   ; Define C function, must have same name
call main       ; Call to C function handled by linker
jmp $