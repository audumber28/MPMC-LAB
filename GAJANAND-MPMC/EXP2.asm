section .data
    array db 7,4,9,1,3,6,2
    len equ $-array
   
    msg1 db 'Before: '
    msg2 db 'After:  '
    newline db 10

section .bss
    temp resb 1

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, 7
    int 80h
   
    xor esi, esi
print1:
    cmp esi, len
    je do_sort
   
    mov al, [array + esi]
    add al, '0'
    mov [temp], al
   
    push esi
    mov eax, 4
    mov ebx, 1
    mov ecx, temp
    mov edx, 1
    int 80h
   
    mov byte [temp], ' '
    mov eax, 4
    mov ebx, 1
    mov ecx, temp
    mov edx, 1
    int 80h
    pop esi
   
    inc esi
    jmp print1

do_sort:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h
   
    xor esi, esi
outer:
    cmp esi, len-1
    jge print_sorted
   
    mov edi, esi
    inc edi
   
inner:
    cmp edi, len
    jge next_outer
   
    mov al, [array + esi]
    mov bl, [array + edi]
    cmp bl, al
    jge no_swap
   
    mov [array + esi], bl
    mov [array + edi], al
   
no_swap:
    inc edi
    jmp inner
   
next_outer:
    inc esi
    jmp outer

print_sorted:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, 7
    int 80h
   
    xor esi, esi
print2:
    cmp esi, len
    je exit
   
    mov al, [array + esi]
    add al, '0'
    mov [temp], al
   
    push esi
    mov eax, 4
    mov ebx, 1
    mov ecx, temp
    mov edx, 1
    int 80h
   
    mov byte [temp], ' '
    mov eax, 4
    mov ebx, 1
    mov ecx, temp
    mov edx, 1
    int 80h
    pop esi
   
    inc esi
    jmp print2

exit:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h
   
    mov eax, 1
    xor ebx, ebx
    int 80h