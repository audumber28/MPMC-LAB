section .data
    prompt db 'Enter your name: ', 0xA
    plen equ $ - prompt
    msg db 'Hello, ', 0
    mlen equ $ - msg

section .bss
    name resb 50

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
    mov ecx, name
    mov edx, 50
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, mlen
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, name
    mov edx, 50
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80
