section .data
    prompt db 'Enter a number: '
    prompt_len equ $ - prompt
    
    greater_msg db 'Number is greater than 5', 10
    greater_len equ $ - greater_msg
    
    less_msg db 'Number is less than 5', 10
    less_len equ $ - less_msg
    
    equal_msg db 'Number is equal to 5', 10
    equal_len equ $ - equal_msg

section .bss
    num resb 5
    value resb 4

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, prompt_len
    int 80h
    
    mov eax, 3
    mov ebx, 0
    mov ecx, num
    mov edx, 5
    int 80h
    
    mov esi, num
    xor eax, eax
    xor ebx, ebx

convert_loop:
    mov bl, [esi]
    cmp bl, 0xA
    je compare
    cmp bl, 0x0
    je compare
    
    sub bl, '0'
    imul eax, 10
    add eax, ebx
    inc esi
    jmp convert_loop

compare:
    cmp eax, 5
    je equal
    jg greater
    jl less

greater:
    mov eax, 4
    mov ebx, 1
    mov ecx, greater_msg
    mov edx, greater_len
    int 80h
    jmp exit

less:
    mov eax, 4
    mov ebx, 1
    mov ecx, less_msg
    mov edx, less_len
    int 80h
    jmp exit

equal:
    mov eax, 4
    mov ebx, 1
    mov ecx, equal_msg
    mov edx, equal_len
    int 80h

exit:
    mov eax, 1
    mov ebx, 0
    int 80h