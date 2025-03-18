section .data
    msg1 db 'Enter first number: '
    msg1_len equ $ - msg1
    msg2 db 'Enter second number: '
    msg2_len equ $ - msg2
    msg3 db 'You entered: '
    msg3_len equ $ - msg3
    space db ','
    newline db 0xA

%macro write 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro read 2
    mov eax, 3
    mov ebx, 0
    mov ecx, %1
    mov edx, %2
    int 80h
    write newline, 1
%endmacro

section .bss
    num1 resb 2
    num2 resb 2

section .text
    global _start

_start:
    write msg1, msg1_len
    read num1, 2
    
    write msg2, msg2_len
    read num2, 2
    
    write msg3, msg3_len
    write num1, 1
    write space, 1
    write num2, 1
    write newline, 1
    
    mov eax, 1
    mov ebx, 0
    int 80h