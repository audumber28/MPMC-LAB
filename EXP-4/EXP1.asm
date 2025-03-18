section .data
    prompt1 db 'Enter first number: '
    len1 equ $ - prompt1
    
    prompt2 db 'Enter second number: '
    len2 equ $ - prompt2
    
    msg db 'Larger number is: '
    msglen equ $ - msg
    
    equal_msg db 'Numbers are equal!'
    equal_len equ $ - equal_msg
    
    newline db 10

section .bss
    num1 resb 2
    num2 resb 2
    result resb 2

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt1
    mov edx, len1
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 2
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, prompt2
    mov edx, len2
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 2
    int 80h

compare:
    mov al, [num1]
    mov bl, [num2]
    sub al, '0'
    sub bl, '0'
    
    cmp al, bl
    je numbers_equal   
    jg first_larger
    jmp second_larger

numbers_equal:
    mov eax, 4
    mov ebx, 1
    mov ecx, equal_msg
    mov edx, equal_len
    int 80h
    jmp print_newline

first_larger:
    add al, '0'
    mov [result], al
    jmp print_result

second_larger:
    add bl, '0'
    mov [result], bl

print_result:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, msglen
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 80h

print_newline:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

exit:
    mov eax, 1
    xor ebx, ebx
    int 80h