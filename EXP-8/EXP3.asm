%macro print 2
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
%endmacro

section .data
    msg db 'Enter the elements of the array: ', 0xA
    plen equ $ - msg
    msg1 db 'Number of even numbers: '
    mlen1 equ $ - msg1
    msg2 db 'Number of odd numbers: '
    mlen2 equ $ - msg2
    newline db 0xA
    nlen equ $ - newline

section .bss
    array resb 5
    num resb 10
    temp resb 1
    even_count resb 1
    odd_count resb 1

section .text
    global _start

_start:
    mov ecx, 5
    mov esi, 0
    mov byte[even_count], 0
    mov byte[odd_count], 0

    push ecx
    print msg, plen
    pop ecx

input_loop:
    push ecx
    read num, 10
    
    mov edi, 0
    mov bl, [num]
    cmp bl, '-'
    jne process_pos
    inc edi
    
process_pos:
    xor eax, eax
    mov ebx, 10

convert_loop:
    movzx ecx, byte[num + edi]
    cmp cl, 0xA
    je end_convert
    
    sub cl, '0'
    mul ebx
    add eax, ecx
    inc edi
    jmp convert_loop

end_convert:
    cmp byte[num], '-'
    jne store_num
    neg eax

store_num:
    mov [array + esi], al
    inc esi
    pop ecx
    loop input_loop

    mov ecx, 5
    mov esi, 0

count_loop:
    mov al, [array + esi]
    cbw
    mov bl, 2
    idiv bl
    cmp ah, 0
    jz even_number
    inc byte[odd_count]
    jmp next_number
even_number:
    inc byte[even_count]
next_number:
    inc esi
    loop count_loop

    print msg1, mlen1
    mov al, [even_count]
    add al, '0'
    mov [temp], al
    print temp, 1
    print newline, nlen

    print msg2, mlen2
    mov al, [odd_count]
    add al, '0'
    mov [temp], al
    print temp, 1
    print newline, nlen

    mov eax, 1
    mov ebx, 0
    int 80h