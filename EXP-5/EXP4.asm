section .data
    msg1 db 'Enter first number: '
    msg1_len equ $ - msg1
    msg2 db 'Enter second number: '
    msg2_len equ $ - msg2
    msg3 db 'Sum: '
    msg3_len equ $ - msg3
    msg4 db 'Difference: '
    msg4_len equ $ - msg4
    msg5 db 'Product: '
    msg5_len equ $ - msg5
    msg6 db 'Quotient: '
    msg6_len equ $ - msg6
    msg7 db 'Remainder: '
    msg7_len equ $ - msg7
    newline db 0xA
    nl_len equ $ - newline

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
    write newline, nl_len
%endmacro

%macro addition 2
    mov al, [num1]
    sub al, '0'
    mov bl, [num2]
    sub bl, '0'
    add al, bl
    add al, '0'
    mov [sum], al
%endmacro

%macro subtraction 2
    mov al, [num1]
    sub al, '0'
    mov bl, [num2]
    sub bl, '0'
    sub al, bl
    add al, '0'
    mov [diff], al
%endmacro

%macro multiply 2
    mov al, [num1]
    sub al, '0'
    mov bl, [num2]
    sub bl, '0'
    mul bl
    aam
    add ax, '00'
    mov [prod], ah
    mov [prod+1], al
%endmacro

%macro division 2
    xor ax, ax
    mov al, [num1]
    sub al, '0'
    mov bl, [num2]
    sub bl, '0'
    div bl
    add al, '0'
    mov [quot], al
    add ah, '0'
    mov [rem], ah
%endmacro

section .bss
    num1 resb 2
    num2 resb 2
    sum resb 1
    diff resb 1
    prod resb 2
    quot resb 1
    rem resb 1

section .text
    global _start

_start:
    write msg1, msg1_len
    read num1, 2
    
    write msg2, msg2_len
    read num2, 2
    
    addition num1, num2
    write msg3, msg3_len
    write sum, 1
    write newline, nl_len
    
    subtraction num1, num2
    write msg4, msg4_len
    write diff, 1
    write newline, nl_len
    
    multiply num1, num2
    write msg5, msg5_len
    write prod, 2
    write newline, nl_len
    
    division num1, num2
    write msg6, msg6_len
    write quot, 1
    write newline, nl_len
    write msg7, msg7_len
    write rem, 1
    write newline, nl_len
    
    mov eax, 1
    mov ebx, 0
    int 80h