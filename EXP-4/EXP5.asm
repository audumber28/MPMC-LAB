section .bss
    str1 resb 50
    str2 resb 50

section .data
    prompt1 db 'Enter first string: '
    len1 equ $ - prompt1
    
    prompt2 db 'Enter second string: '
    len2 equ $ - prompt2
    
    msg db 'Smaller string is: '
    msglen equ $ - msg
    
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
    mov ecx, str1
    mov edx, 50
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, prompt2
    mov edx, len2
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, str2
    mov edx, 50
    int 80h

compare:
    mov esi, str1
    mov edi, str2
    
next_char:
    mov al, [esi]
    mov bl, [edi]
    
    cmp al, bl
    jl str1_smaller
    jg str2_smaller
    
    cmp al, 0
    je str1_smaller
    
    inc esi
    inc edi
    jmp next_char

str1_smaller:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, msglen
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, str1
    mov edx, 50
    int 80h
    jmp exit

str2_smaller:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, msglen
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, str2
    mov edx, 50
    int 80h

exit:
    mov eax, 1
    xor ebx, ebx
    int 80h
