C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

OBJ = ${C_SOURCES:.c=.o}

CFLAGS = -g # debug

os-image.bin: boot/bootsect.bin kernel.bin
	cat $^ > os-image.binary

kernel.bin: boot/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary

# Used for debugging purposes
kernel.elf: boot/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ 

run: os-image.bin
	qemu-system-x86_64 os-image.bin

debug: os-image.bin kernel.elf
	qemu-system-x86_64 -s os-image.bin &
	gdb -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

%.o: %.c ${HEADERS}
	gcc ${CFLAGS} -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -felf64 -o $@

%.bin: %.asm
	nasm $< -fbin -o $@

clean:
	rm -rf *.bin *.dis *.o *.elf
	rm -rf kernel/*.o boot/*.bin drivers/*.o boot/*.o
