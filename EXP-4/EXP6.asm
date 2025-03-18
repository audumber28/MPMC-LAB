section .data
    prompt db 'Enter a number: '
    prompt_len equ $ - prompt
    
    even_msg db 'Number is Even', 10
    even_len equ $ - even_msg
    
    odd_msg db 'Number is Odd', 10
    odd_len equ $ - odd_msg

section .bss
    num resb 2
    
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
    mov edx, 2
    int 80h
    
    mov al, [num]
    sub al, '0'
    
    mov bl, 2
    div bl
    
    cmp ah, 0
    je even_number
    
odd_number:
    mov eax, 4
    mov ebx, 1
    mov ecx, odd_msg
    mov edx, odd_len
    int 80h
    jmp exit
    
even_number:
    mov eax, 4
    mov ebx, 1
    mov ecx, even_msg
    mov edx, even_len
    int 80h
    
exit:
    mov eax, 1
    xor ebx, ebx
    int 80h