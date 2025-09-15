nasm -f macho64 asmqs.asm -o asmqs.o
clang -target x86_64-apple-macos10.15 -o asmqs asmqs.o

