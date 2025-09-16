# Asmsort

This project uses nasm and clang to assemble and link an x86-64 asm program on macos. On intel mac it should run without translation, while on apple silicon the operating system will use rosetta 2, a built in translation layer, to run the binary.

![alt text of program running in terminal]("img1.png")

The program sorts an array with selection sort and times it. It also checks the sum of the array before and after sorting, which also is counted in the timer. 
