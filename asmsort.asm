section .data
  arr1 dd 3, 2, 4, 1, 5, 2, 4, 8, 2, 4, 6, 7, 3, 4, 6, 3, 2, 5, 7
  len1 equ ($ - arr1)/4
  dmsg db "%d ", 0
  nlmsg db "", 10, 0
  tmsg db "Elapsed cycles: %llu", 10, 0

section .bss
  sum1 resd 1
  sum2 resd 1
  time1 resq 1
  time2 resq 1

section .text
  global _main
  extern _printf
  extern _exit

; rdi points to array
; rsi length
; r13b return byte
is_sorted:
  xor r12, r12
  mov r13, rdi
  mov r14, rsi
  dec r14

.issl:
  cmp r12, r14
  jge .isst
  mov eax, [r13 + r12*4]
  mov ecx, [r13 + r12*4 + 4]
  cmp eax, ecx
  jg .issf
  inc r12
  jmp .issl

.issf:
  mov r13b, 1
  ret

.isst:
  mov r13b, 0
  ret

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

; rdi points to time
time:
  xor rax, rax
  cpuid
  rdtsc
  shl rdx, 32
  or rax, rdx
  mov [rdi], rax
  ret

; rdi points to time1
; rsi points to time2
time_diff_out:
  mov rax, [rsi]
  sub rax, [rdi]
  mov rsi, rax
  lea rdi, [rel tmsg]
  xor rax, rax
  call _printf
  ret

_main:
  lea rdi, [rel time1]
  call time

  lea rdi, [rel arr1]
  lea rsi, [rel sum1]
  mov rdx, len1
  call sum

  lea rdi, [rel arr1]
  mov rsi, len1
  call sort

  lea rdi, [rel arr1]
  mov rsi, len1
  call is_sorted

  cmp r13b, 1
  je .badsort

  lea rdi, [rel arr1]
  lea rsi, [rel sum2]
  mov rdx, len1
  call sum

  mov eax, [rel sum1]
  cmp eax, [rel sum2]
  jne .badsum

  lea rdi, [rel time2]
  call time

  lea rdi, [rel time1]
  lea rsi, [rel time2]
  call time_diff_out

  lea rdi, [rel arr1]
  mov rsi, len1
  call arrout

  jmp .done

.badsum:
  mov rdi, 1
  call _exit

.badsort:
  mov rdi, 2
  call _exit

.done:
  xor rdi, rdi
  call _exit
