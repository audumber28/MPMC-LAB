section .data
    prompt db 'Please enter your name > '
    prompt_len equ $ - prompt
    newline db 0xa
    iterations db 7

section .bss
    username resb 30
    len resb 1

%macro writeMsg 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 0x80
%endmacro

%macro readInput 0
    mov eax, 3
    mov ebx, 0
    mov ecx, username
    mov edx, 30
    int 0x80
%endmacro

%macro printNewline 0
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
%endmacro

%macro getLength 0
    mov esi, username
    xor ecx, ecx
%%nextchar:
    cmp byte[esi], 0xa
    je %%done
    inc ecx
    inc esi
    jmp %%nextchar
%%done:
    mov [len], ecx
%endmacro

%macro printName 0
    mov byte[iterations], 7
%%repeat:
    writeMsg username, [len]
    printNewline
    dec byte[iterations]
    jnz %%repeat
%endmacro

section .text
    global _start

_start:
    writeMsg prompt, prompt_len
    readInput
    getLength
    printName
    
    mov eax, 1
    xor ebx, ebx
    int 0x80