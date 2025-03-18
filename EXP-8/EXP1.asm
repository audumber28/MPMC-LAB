section .data
    prompt_count     db  "Enter number of elements (max 20): ", 0
    prompt_element   db  "Enter element %d: ", 0
    display_header   db  "Array elements:", 10, 0
    element_format   db  "Element[%d] = %d", 10, 0
    input_format     db  "%d", 0
    newline          db  10, 0
    max_elements     equ 20
    too_large_msg    db "Error: Maximum allowed elements is %d", 10, 0

section .bss
    array       resd    max_elements
    count       resd    1

section .text
    extern printf, scanf
    global main

main:
    push ebp
    mov ebp, esp
    sub esp, 8

    push prompt_count
    call printf
    add esp, 4

    lea eax, [count]
    push eax
    push input_format
    call scanf
    add esp, 8

    mov eax, [count]
    cmp eax, 0
    jle exit
    cmp eax, max_elements
    jg too_large

    xor esi, esi

input_loop:
    cmp esi, [count]
    jae display_array

    push esi
    inc dword [esp]
    push prompt_element
    call printf
    add esp, 8

    lea eax, [array + esi*4]
    push eax
    push input_format
    call scanf
    add esp, 8

    inc esi
    jmp input_loop

display_array:
    push display_header
    call printf
    add esp, 4

    xor esi, esi

display_loop:
    cmp esi, [count]
    jae exit

    mov edx, [array + esi*4]
    push edx
    push esi
    push element_format
    call printf
    add esp, 12

    inc esi
    jmp display_loop

too_large:
    push max_elements
    push dword too_large_msg
    call printf
    add esp, 8
    jmp exit

exit:
    push newline
    call printf
    add esp, 4

    xor eax, eax
    mov esp, ebp
    pop ebp
    ret