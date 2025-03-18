section .data
    prompt db 'Enter a number: '
    plen equ $ - prompt
    msg db 'Your number is: '
    mlen equ $ - msg

section .bss
    num resb 5

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, plen
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, num
    mov edx, 5
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, mlen
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, num
    mov edx, 5
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80