section .data
  arr1 dd 1, 2, 3, 4, 5
  arr2 dd 2, 3, 4, 5, 6, 7
  len1 equ 5
  len2 equ 6
  msg db "%d", 10, 0

section .bss
  sum1 resd 1
  sum2 resd 1

section .text
  global _main
  extern _printf
  extern _exit

sort:
  ret

; rbx points to array
; rsi points to sum
; r12 length
sum:
  xor rbp, rbp
  xor rdx, rdx

.suml:
  cmp rbp, r12
  jge .sumd
  mov eax, [rbx + rbp*4]
  add edx, eax
  inc rbp
  jmp .suml

.sumd:
  mov [rsi], edx
  ret

; rsi points to sum
sumout:
  mov esi, dword [rsi]
  lea rdi, [rel msg]
  xor rax, rax
  call _printf
  ret

; rbx points to array
; r12 length
arrout:
  xor rbp, rbp
  xor rdx, rdx

.arroutl:
  cmp rbp, r12
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
  lea rsi, [rel sum1]
  lea rbx, [rel arr1]
  mov r12, len1
  call sum
  call sumout

  lea rsi, [rel sum2]
  lea rbx, [rel arr2]
  mov r12, len2
  call sum
  call sumout

  xor rdi, rdi
  call _exit
