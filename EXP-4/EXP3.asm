section .bss
    num1 resb 10    
    num2 resb 10    
    num3 resb 10    
    result resb 10  
    buffer resb 10

section .data
    prompt1 db 'Enter first number: '
    len1 equ $ - prompt1
    
    prompt2 db 'Enter second number: '
    len2 equ $ - prompt2
    
    prompt3 db 'Enter third number: '
    len3 equ $ - prompt3
    
    min_msg db 'Smallest number: '
    min_len equ $ - min_msg

    eq db 'equal numbers '
    eq_len equ $ - eq
    
    newline db 10

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
    mov edx, 10
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, prompt2
    mov edx, len2
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 10
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, prompt3
    mov edx, len3
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, num3
    mov edx, 10
    int 80h

    mov al, [num1]
    sub al, '0'
    mov bl, [num2] 
    sub bl, '0'
    mov cl, [num3]
    sub cl, '0'

    cmp al, bl
    jle check_third
    mov al, bl

check_third:
    cmp al, cl
    je print
    jle print_result
    mov al, cl

print:
add al,'0'
mov [result],al
mov eax, 4
    mov ebx, 1
    mov ecx, eq
    mov edx, eq_len
    int 80h

mov eax, 1
    xor ebx, ebx
    int 80h

print_result:
    add al, '0'
    mov [result], al

    mov eax, 4
    mov ebx, 1
    mov ecx, min_msg
    mov edx, min_len
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

    mov eax, 1
    xor ebx, ebx
    int 80h
