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
    prompt_size db 'Enter size of array (1-9): ', 0xA
    size_len equ $ - prompt_size
    
    prompt_elem db 'Enter array elements:', 0xA
    elem_len equ $ - prompt_elem
    
    sum_msg db 'Sum of array elements: '
    sum_len equ $ - sum_msg
    
    newline db 0xA
    nlen equ $ - newline
    
    minus db '-'
    minus_len equ $ - minus

section .bss
    array resd 100       ; Array to store integers (4 bytes each)
    size resb 1          ; Size of array
    num resb 10          ; Buffer for number input
    sum resd 1          ; To store sum
    temp resb 10        ; Temporary buffer for number conversion
    is_negative resb 1   ; Flag for negative numbers

section .text
    global _start

_start:
    ; Get array size
    print prompt_size, size_len
    read num, 2
    mov al, [num]
    sub al, '0'
    mov [size], al
    
    ; Get array elements
    print prompt_elem, elem_len
    
    ; Initialize array input
    xor esi, esi        ; Array index
    movzx ecx, byte[size]
    
input_loop:
    push ecx            ; Save counter
    
    ; Read number
    read num, 10
    
    ; Initialize conversion
    xor ebx, ebx        ; Will hold the number
    mov edi, 0          ; String index
    mov byte[is_negative], 0
    
    ; Check for negative sign
    mov al, [num]
    cmp al, '-'
    jne convert_number
    mov byte[is_negative], 1
    inc edi
    
convert_number:
    movzx eax, byte[num + edi]
    cmp al, 0xA         ; Check for newline
    je end_conversion
    
    sub al, '0'         ; Convert ASCII to number
    imul ebx, 10        ; Multiply current number by 10
    movzx eax, al       ; Clear upper bits
    add ebx, eax        ; Add new digit
    inc edi
    jmp convert_number
    
end_conversion:
    ; Apply negative sign if needed
    cmp byte[is_negative], 1
    jne store_number
    neg ebx
    
store_number:
    mov [array + esi*4], ebx
    add esi, 1
    pop ecx
    loop input_loop
    
    ; Calculate sum
    xor ebx, ebx        ; Initialize sum to 0
    xor esi, esi        ; Reset array index
    movzx ecx, byte[size]
    
sum_loop:
    add ebx, [array + esi*4]
    inc esi
    loop sum_loop
    
    mov [sum], ebx
    
    ; Print sum message
    print sum_msg, sum_len
    
    ; Convert sum to string and print
    mov eax, [sum]
    
    ; Check if sum is negative
    mov byte[is_negative], 0
    test eax, eax
    jns convert_sum
    mov byte[is_negative], 1
    neg eax
    
convert_sum:
    mov edi, temp
    add edi, 9          ; Start from end of buffer
    mov byte[edi], 0    ; Null terminate
    mov ebx, 10
    
convert_loop:
    dec edi
    xor edx, edx
    div ebx
    add dl, '0'
    mov [edi], dl
    test eax, eax
    jnz convert_loop
    
    ; Print minus if negative
    cmp byte[is_negative], 1
    jne print_result
    print minus, minus_len
    
print_result:
    ; Calculate length of number
    mov edx, temp
    add edx, 9
    sub edx, edi
    print edi, edx
    
    ; Print newline
    print newline, nlen
    
    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 80h