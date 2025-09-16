section .data
  arr1 dd 3, 2, 4, 1, 5, 2, 4, 8, 2, 4, 6, 7, 3, 4, 6, 3, 2, 5, 7
  len1 equ ($ - arr1)/4
  dmsg db "%d ", 0
  nlmsg db "", 10, 0
  smsg db "Sum: %d", 10, 0

section .bss
  sum1 resd 1
  sum2 resd 1

section .text
  global _main
  extern _printf
  extern _exit

; rdi points to array
; rsi length
sort:
  xor r12, r12
  mov r14, rsi
  mov r15, rdi

.sort_outl:
  cmp r12, r14
  jge .done
  mov rax, r12
  xor r13, r13
  mov r13, r12
  inc r13

.sort_innl:
  cmp r13, r14
  jge .sort_outd
  mov edx, [r15 + r13*4]
  mov ecx, [r15 + rax*4]
  cmp edx, ecx
  jge .no_update
  mov  rax, r13

.no_update:
  inc r13
  jmp .sort_innl

.sort_outd:
  cmp rax, r12
  je  .no_swap
  mov ebx, [r15 + r12*4]
  mov edx, [r15 + rax*4]
  mov [r15 + r12*4], edx
  mov [r15 + rax*4], ebx

.no_swap:
  inc r12
  jmp .sort_outl

.done:
  ret

; rdi points to array
; rsi points to sum
; rdx length
sum:
  xor eax, eax
  xor r12, r12
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
  lea rdi, [rel smsg]
  xor rax, rax
  call _printf
  ret

; rdi points to array
; rsi length
arrout:
  xor r12, r12
  mov r13, rsi
  mov r14, rdi

.arroutl:
  cmp r12, r13
  jge .arroutd
  mov esi, [r14 + r12*4]
  lea rdi, [rel dmsg]
  xor rax, rax
  call _printf
  inc r12
  jmp .arroutl

.arroutd:
  lea rdi, [rel nlmsg]
  xor rax, rax
  call _printf
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

  lea rdi, [rel arr1]
  mov rsi, len1
  call sort
 
  lea rdi, [rel arr1]
  lea rsi, [rel sum2]
  mov rdx, len1
  call sum

  lea rdi, [rel sum2]
  call sumout

  lea rdi, [rel arr1]
  mov rsi, len1
  call arrout

  mov eax, [rel sum1]
  cmp eax, [rel sum2]
  je .done

  mov rdi, 1
  call _exit

.done:
  xor rdi, rdi
  call _exit
