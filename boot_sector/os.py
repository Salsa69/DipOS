import os
import sys

command = f"nasm -fbin {sys.argv[1]}.asm -o {sys.argv[1]}.bin && qemu-system-x86_64 {sys.argv[1]}.bin"

os.system(command)
