section .data
    array dd 1, 2, 3, 4, 5, 6, 7, 11, 15, 18
    len equ 10
    fmt db "%d", 10, 0

section .text
    global _main
    extern _printf

_main:
    lea rbx, [rel array]      ; pointer to first element
    mov rbp, 0                ; counter for printed elements

.next:
    cmp rbp, len              ; check if we printed 5 elements
    je .done                  ; stop when value is 5

    movzx rsi, byte [rbx]     ; load next element
    lea rdi, [rel fmt]        ; format string
    xor rax, rax
    call _printf

    add rbx, 4                ; move to next element
    inc rbp                   ; increment printed counter
    jmp .next

.done:
    mov rax, 0x2000001        ; syscall exit
    xor rdi, rdi
    syscall

