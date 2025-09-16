nasm -f macho64 asmsort.asm -o asmsort.o
clang -target x86_64-apple-macos10.15 -o asmsort asmsort.o

