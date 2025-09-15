section .data
    arr dd 1, 2, 3, 4, 5, 6
    len equ 6
    fmt db "%d",10,0

section .text
    global _main
    extern _printf
    extern _exit

_main:
    sub rsp, len*4 + 8        ; allocate space on stack
    lea rsi, [rel arr]        ; source of array
    lea rdi, [rsp]            ; destination on stack
    mov rcx, len              ; number of dwords to copy
    rep movsd                 ; copy 10 dwords
    xor rbp, rbp              ; index counter

.print_loop:
    cmp rbp, len
    je .done
    mov eax, [rsp + rbp*4]   ; read element from cloned array
    mov esi, eax             ; first integer argument for _printf
    lea rdi, [rel fmt]       ; format string
    xor rax, rax             ; required for variadic functions
    call _printf
    inc rbp
    jmp .print_loop

.done:
    add rsp, len*4 + 8       ; free stack
    mov rdi, 0               ; exit code 0
    call _exit

