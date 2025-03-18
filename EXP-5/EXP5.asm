section .data
    string1 db "Enter size of fibonacci series: ", 10
    string1len equ $-string1
    string2 db "The series is: ", 10
    string2len equ $-string2
    newline db '', 10
    nl equ $-newline

section .bss
    num resb 5
    a resb 5
    b resb 5
    c resb 5
    inter resb 5
    count resb 5

%macro write 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro read 1
    mov eax, 3
    mov ebx, 2
    mov ecx, %1
    mov edx, 5
    int 80h
%endmacro

%macro addition 3
    mov eax, [%1]
    sub eax, '0'
    mov ebx, [%2]
    sub ebx, '0'
    add eax, ebx
    add eax, '0'
    mov [%3], eax
%endmacro

section .text 
    global _start
_start: 
    write string1, string1len
    read num
    write string2, string2len
    mov eax,[num]
    sub eax, '0'
    mov [num], eax
    
    mov al,[num]
    cmp al, 0
    je  exit

    mov eax, '0'
    mov [a], eax
    write a, 5
    write newline, nl
    mov al,[num]
    cmp al, 1
    je  exit
    mov eax, '1'
    mov [b], eax
    write b, 5
    write newline, nl
    mov al,[num]
    cmp al, 2
    je  exit

    mov eax, 2
    mov [count], eax
    L1:
        addition a, b, c
        write c, 9
        write newline, nl

        mov eax, [b]
        mov [a], eax

        mov eax, [c]
        mov [b], eax

        inc byte[count]

        mov al, [count]
        mov bl, [num]
        cmp al, bl
        jl L1
    exit:
        mov eax, 1
        mov ebx, 0
        int 80h