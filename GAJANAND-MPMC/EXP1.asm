section .data
    array db 1, 4, 7, 9, 2, 5, 8, 3, 6
    len equ $ - array
    target db 1
   
    msg_found db "Number found!", 0xA
    len_found equ $ - msg_found
   
    msg_not_found db "Number not found!", 0xA
    len_not_found equ $ - msg_not_found

section .text
    global _start

_start:
    xor ecx, ecx
    mov bl, [target]

check_loop:
    cmp ecx, len
    je not_found
   
    mov al, [array + ecx]
    cmp al, bl
    je found
   
    inc ecx
    jmp check_loop

found:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_found
    mov edx, len_found
    int 0x80  
    jmp exit

not_found:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_not_found
    mov edx, len_not_found
    int 0x80

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80
