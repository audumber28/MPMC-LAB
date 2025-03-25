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
   
    prompt_elem db 'Enter array elements:', 0xA
    elem_len equ $ - prompt_elem
    sum_msg db 'Sum of array elements: '
    sum_len equ $ - sum_msg
    newline db 0xA
    nlen equ $ - newline
    minus db '-'
    minus_len equ $ - minus

section .bss
    array resd 5
    num resb 10
    sum resd 1
    temp resb 10
    is_negative resb 1

section .text
    global _start

_start:
   
    xor esi, esi
    mov ecx, 5

input_loop:
    push ecx
    read num, 10
    xor ebx, ebx
    mov edi, 0
    mov byte[is_negative], 0
    
    mov al, [num]
    cmp al, '-'
    jne convert_number
    mov byte[is_negative], 1
    inc edi
    
convert_number:
    movzx eax, byte[num + edi]
    cmp al, 0xA
    je end_conversion
    
    sub al, '0'
    imul ebx, 10
    movzx eax, al
    add ebx, eax
    inc edi
    jmp convert_number
    
end_conversion:
    cmp byte[is_negative], 1
    jne store_number
    neg ebx
    
store_number:
    mov [array + esi*4], ebx
    add esi, 1
    pop ecx
    loop input_loop
    
    xor ebx, ebx
    xor esi, esi
    mov ecx, 5
    
sum_loop:
    add ebx, [array + esi*4]
    inc esi
    loop sum_loop
    
    mov [sum], ebx
    print sum_msg, sum_len
    
    mov eax, [sum]
    mov byte[is_negative], 0
    test eax, eax
    jns convert_sum
    mov byte[is_negative], 1
    neg eax
    
convert_sum:
    mov edi, temp
    add edi, 9
    mov byte[edi], 0
    mov ebx, 10
    
convert_loop:
    dec edi
    xor edx, edx
    div ebx
    add dl, '0'
    mov [edi], dl
    test eax, eax
    jnz convert_loop
    
    cmp byte[is_negative], 1
    jne print_result
    print minus, minus_len
    
print_result:
    mov edx, temp
    add edx, 9
    sub edx, edi
    print edi, edx
    print newline, nlen
    
    mov eax, 1
    xor ebx, ebx
    int 80h