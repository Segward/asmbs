section .data
  arr dd 1, 2, 3, 4, 5
  len equ 5
  msg db "%d", 10, 0

section .bss
  _sum resd 1

section .text
  global _main
  extern _printf
  extern _exit

sum:
  xor rbp, rbp
  xor rdx, rdx
  lea rbx, [rel arr]

.suml:
  cmp rbp, len
  jge .sumd
  mov eax, [rbx + rbp*4]
  add edx, eax
  inc rbp
  jmp .suml

.sumd:
  mov [rel _sum], edx
  ret

sumout:
  mov esi, dword [rel _sum]
  lea rdi, [rel msg]
  xor rax, rax
  call _printf
  ret

arrout:
  xor rbp, rbp
  xor rdx, rdx
  lea rbx, [rel arr]

.arroutl:
  cmp rbp, len
  jge .arroutd

  mov esi, [rbx + rbp*4]
  lea rdi, [rel msg]
  xor rax, rax
  call _printf

  inc rbp
  jmp .arroutl

.arroutd:
  ret

_main:
  call sum
  call sumout
  call arrout

  xor rdi, rdi
  call _exit
