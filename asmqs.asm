section .data
  arr dd 1, 2, 3, 4, 5
  msg db "%d", 10, 0

section .bss
  _sum resd 1

section .text
  global _main
  extern _printf
  extern _exit

sum:
  xor rcx, rcx
  xor rdx, rdx
  lea rbx, [rel arr]

.suml:
  cmp rcx, 5
  jge .sumd
  mov rax, [rbx + rcx*4]
  add rdx, rax
  inc rcx
  jmp .suml

.sumd:
  mov [rel _sum], rdx
  ret

_main:
  call sum

  mov rax, [rel _sum]
  mov rdi, rax
  call _exit
