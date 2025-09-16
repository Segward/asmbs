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

; rdi points to array
; rsi points to sum
; rdx length
sum:
  xor eax, eax
  mov r12, 0
  mov r13, rdx
  mov r14, rdi

.suml:
  cmp r12, r13
  jge .sumd
  mov ebx, [r14 + r12*4]
  add eax, ebx
  inc r12
  jmp .suml

.sumd:
  mov [rsi], eax
  ret

; rdi points to sum
sumout:
  mov esi, [rdi]
  lea rdi, [rel msg]
  xor rax, rax
  call _printf
  ret

; rdi points to array
; rsi length
arrout:
  mov r12, 0
  mov r13, rsi
  mov r14, rdi

.arroutl:
  cmp r12, r13
  jge .arroutd
  mov esi, [r14 + r12*4]
  lea rdi, [rel msg]
  xor rax, rax
  call _printf
  inc r12
  jmp .arroutl

.arroutd:
  ret

_main:
  lea rdi, [rel arr1]
  lea rsi, [rel sum1]
  mov rdx, len1
  call sum

  lea rdi, [rel sum1]
  call sumout

  lea rdi, [rel arr1]
  mov rsi, len1
  call arrout

  lea rdi, [rel arr2]
  lea rsi, [rel sum2]
  mov rdx, len2
  call sum

  lea rdi, [rel sum2]
  call sumout

  lea rdi, [rel arr2]
  mov rsi, len2
  call arrout

  xor rdi, rdi
  call _exit
