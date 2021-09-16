import sys, os
os.system(f"gcc -ffreestanding -c {sys.argv[1]}.c -o bin/{sys.argv[1]}.o && objdump -d bin/{sys.argv[1]}.o")