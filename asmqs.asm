section .data
  arr db 10, 20, 30, 40
  msg db "Sum of array: %d", 10, 0

section .bss
  _sum resb 1

section .text
  global _main
  extern _printf
  extern _exit

sum_arr:
  push rax
  push rcx
  push rbx
  push rsi
  push rdi

  xor rax, rax
  xor rcx, rcx
  lea rbx, [rel arr]

.sum_loop:
  cmp rcx, 4
  jge .sum_done
  mov bl, [rbx + rcx]
  add al, bl
  inc rcx
  jmp .sum_loop

.sum_done:
  mov [rel _sum], al

  pop rdi
  pop rsi
  pop rbx
  pop rcx
  pop rax

  ret  

out_sum:
  push rsi
  push rdi
  push rax

  movzx rsi, byte [rel _sum]
  lea rdi, [rel msg]
  xor rax, rax
  call _printf

  pop rax
  pop rdi
  pop rsi

  ret


_main:
  call sum_arr
  call out_sum

  mov rdi, 0
  call _exit
