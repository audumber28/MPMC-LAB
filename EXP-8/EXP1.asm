section .data
    prompt_msg db 'Enter number of elements (1-100): ', 0
    prompt_len equ $ - prompt_msg
    
    input_msg db 'Enter element: ', 0
    input_len equ $ - input_msg
    
    output_msg db 'Array elements are:', 0xA, 0
    output_len equ $ - output_msg
    
    error_msg db 'Invalid input, try again', 0xA, 0
    error_len equ $ - error_msg
    
    range_error_msg db 'Number must be between 1 and 100', 0xA, 0
    range_error_len equ $ - range_error_msg
    
    space db ' ', 0
    newline db 0xA, 0
    minus db '-', 0
    
section .bss
    array resw 100
    num_elements resw 1
    input_buf resb 16
    
section .text
    global _start
_start:
get_num_elements:
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_msg
    mov edx, prompt_len
    int 0x80
    
    call read_num
    
    cmp eax, 1
    jl invalid_range
    cmp eax, 100
    jg invalid_range
    
    mov [num_elements], ax
    
    xor esi, esi
    jmp input_loop
    
invalid_range:
    mov eax, 4
    mov ebx, 1
    mov ecx, range_error_msg
    mov edx, range_error_len
    int 0x80
    jmp get_num_elements
    
input_loop:
    cmp si, [num_elements]
    jge display_array
    
    mov eax, 4
    mov ebx, 1
    mov ecx, input_msg
    mov edx, input_len
    int 0x80
    
    call read_num_signed
    
    cmp edx, -1
    je invalid_input
    
    mov [array + esi*2], ax
    inc esi
    jmp input_loop
    
invalid_input:
    mov eax, 4
    mov ebx, 1
    mov ecx, error_msg
    mov edx, error_len
    int 0x80
    jmp input_loop
    
display_array:
    mov eax, 4
    mov ebx, 1
    mov ecx, output_msg
    mov edx, output_len
    int 0x80
    
    xor esi, esi
    
output_loop:
    cmp si, [num_elements]
    jge exit_program
    
    movsx eax, word [array + esi*2]
    call print_num_signed
    
    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 1
    int 0x80
    
    inc esi
    jmp output_loop
    
exit_program:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    
    mov eax, 1
    xor ebx, ebx
    int 0x80

read_num:
    mov eax, 3
    mov ebx, 0
    mov ecx, input_buf
    mov edx, 16
    int 0x80
    
    cmp eax, 1
    jl read_error
    
    xor eax, eax
    xor ebx, ebx
    mov ecx, input_buf
    
convert_loop:
    movzx edx, byte [ecx]
    
    cmp dl, 0xA
    je done_convert
    cmp dl, 0
    je done_convert
    
    cmp dl, '0'
    jl read_error
    cmp dl, '9'
    jg read_error
    
    sub dl, '0'
    imul eax, 10
    add eax, edx
    
    cmp eax, 65535
    jg read_error
    
    inc ecx
    jmp convert_loop
    
read_error:
    mov eax, -1
    ret
    
done_convert:
    ret

read_num_signed:
    push ebp
    mov ebp, esp
    push edi
    
    mov eax, 3
    mov ebx, 0
    mov ecx, input_buf
    mov edx, 16
    int 0x80
    
    cmp eax, 1
    jl read_signed_error
    
    xor eax, eax
    xor ebx, ebx
    mov ecx, input_buf
    xor edi, edi
    
    movzx edx, byte [ecx]
    cmp dl, '-'
    jne check_digit
    
    mov edi, 1
    inc ecx
    
check_digit:
    movzx edx, byte [ecx]
    
    cmp dl, 0xA
    je done_convert_signed
    cmp dl, 0
    je done_convert_signed
    
    cmp dl, '0'
    jl read_signed_error
    cmp dl, '9'
    jg read_signed_error
    
    sub dl, '0'
    imul eax, 10
    add eax, edx
    
    cmp eax, 32768
    jg read_signed_error
    
    inc ecx
    jmp check_digit
    
read_signed_error:
    mov eax, 0
    mov edx, -1
    jmp read_signed_exit
    
done_convert_signed:
    test edi, edi
    jz positive_number
    
    neg eax
    
positive_number:
    mov edx, 0
    
read_signed_exit:
    pop edi
    mov esp, ebp
    pop ebp
    ret

print_num_signed:
    push ebx
    push ecx
    push edx
    push esi
    
    test eax, eax
    jns positive_print
    
    push eax
    
    mov eax, 4
    mov ebx, 1
    mov ecx, minus
    mov edx, 1
    int 0x80
    
    pop eax
    neg eax
    
positive_print:
    mov ecx, input_buf
    add ecx, 15
    mov byte [ecx], 0
    
    test eax, eax
    jnz not_zero
    
    dec ecx
    mov byte [ecx], '0'
    jmp print_digits
    
not_zero:
    mov ebx, 10
    
convert_to_string:
    dec ecx
    xor edx, edx
    div ebx
    add dl, '0'
    mov [ecx], dl
    test eax, eax
    jnz convert_to_string
    
print_digits:
    mov esi, input_buf
    add esi, 15
    sub esi, ecx
    
    mov eax, 4
    mov ebx, 1
    mov edx, esi
    int 0x80
    
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret