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

section .text 
    global _start

write_proc:
    mov eax, 4
    mov ebx, 1
    ret

read_proc:
    mov eax, 3
    mov ebx, 2
    mov edx, 5
    ret

addition_proc:
    mov eax, [ecx]
    sub eax, '0'
    mov ebx, [edx]
    sub ebx, '0'
    add eax, ebx
    add eax, '0'
    mov [esi], eax
    ret

_start: 
    mov ecx, string1
    mov edx, string1len
    call write_proc
    int 80h

    mov ecx, num
    call read_proc
    int 80h

    mov ecx, string2
    mov edx, string2len
    call write_proc
    int 80h

    mov eax,[num]
    sub eax, '0'
    mov [num], eax
    
    mov al,[num]
    cmp al, 0
    je  exit

    mov eax, '0'
    mov [a], eax
    mov ecx, a
    mov edx, 5
    call write_proc
    int 80h
    mov ecx, newline
    mov edx, nl
    call write_proc
    int 80h
    
    mov al,[num]
    cmp al, 1
    je  exit

    mov eax, '1'
    mov [b], eax
    mov ecx, b
    mov edx, 5
    call write_proc
    int 80h
    mov ecx, newline
    mov edx, nl
    call write_proc
    int 80h
    
    mov al,[num]
    cmp al, 2
    je  exit

    mov eax, 2
    mov [count], eax

L1:
    mov ecx, a
    mov edx, b
    mov esi, c
    call addition_proc

    mov ecx, c
    mov edx, 9
    call write_proc
    int 80h
    
    mov ecx, newline
    mov edx, nl
    call write_proc
    int 80h

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