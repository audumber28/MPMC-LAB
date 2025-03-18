section .data
    prompt db 'Enter two strings: ', 0
    plen equ $ - prompt
    msg db 'Entered strings are: ', 0
    mlen equ $ - msg
    newline db 0xA
    nlen equ $ - newline
    space db ' '
    slen equ $ - space

%macro writesystem 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro readsystem 2
    mov eax, 3
    mov ebx, 0
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

section .bss
    string1 resb 50
    string2 resb 50

section .text
    global _start

_start:
    writesystem prompt, plen
    
    readsystem string1, 50
    
    readsystem string2, 50
    
    writesystem msg, mlen
    writesystem newline, nlen
    
    writesystem string1, 50
    
    writesystem space, slen
    
    writesystem string2, 50
    
    mov eax, 1
    xor ebx, ebx
    int 0x80