nasm -f macho64 asmbs.asm -o asmbs.o
clang -target x86_64-apple-macos10.15 -o asmbs asmbs.o

