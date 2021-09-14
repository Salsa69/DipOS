void dummy() { // Ensures main isn't at 0x0000
}

void clear_screen() {
    char* videoMemory = (char*) 0xb8000;
    for (int i = 0; i < 1000; i++) {
        *videoMemory = '\0';
        videoMemory += 2;
    }
}

void main() {
    char* videoMemory = (char*) 0xb8000;
    *videoMemory = '!';
}
