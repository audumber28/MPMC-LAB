%macro write 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 0x80
%endmacro

section .data
    number db '42'
    len equ $ - number
    space db ' '       
    newline db 0xa     

section .text
    global _start

_start:
    write number, len
    write space, 1      
    write newline, 1    

    mov eax, 1
    xor ebx, ebx
    int 0x80