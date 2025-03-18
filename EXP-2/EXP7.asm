SECTION .bss
    num: resb 10
    str: resb 100

SECTION .data
    prompt_num db "Enter a number: "
    prompt_num_len equ $ - prompt_num
    prompt_str db "Enter a string: "
    prompt_str_len equ $ - prompt_str
    output_num db "You entered the number: "
    output_num_len equ $ - output_num
    output_str db "You entered the string: "
    output_str_len equ $ - output_str
    newline db 10

SECTION .text
    global _start

_start:
    ; Print prompt_num
    mov eax, 4              
    mov ebx, 1              
    mov ecx, prompt_num     
    mov edx, prompt_num_len 
    int 0x80                

    ; Read input for num
    mov eax, 3              
    mov ebx, 0              
    mov ecx, num            
    mov edx, 9              
    int 0x80                

    ; Print prompt_str
    mov eax, 4              
    mov ebx, 1              
    mov ecx, prompt_str     
    mov edx, prompt_str_len 
    int 0x80                

    ; Read input for str
    mov eax, 3              
    mov ebx, 0              
    mov ecx, str            
    mov edx, 99             
    int 0x80                
    push eax                

    ; Print output_num
    mov eax, 4              
    mov ebx, 1              
    mov ecx, output_num     
    mov edx, output_num_len 
    int 0x80                

    ; Print num
    mov eax, 4              
    mov ebx, 1              
    mov ecx, num            
    mov edx, 9              
    int 0x80                

    ; Print output_str
    mov eax, 4              
    mov ebx, 1              
    mov ecx, output_str     
    mov edx, output_str_len 
    int 0x80                

    ; Print str
    mov eax, 4              
    mov ebx, 1              
    mov ecx, str            
    pop edx                 
    int 0x80                

    ; Print final newline
    mov eax, 4              
    mov ebx, 1              
    mov ecx, newline        
    mov edx, 1              
    int 0x80                

    ; Exit program
    mov eax, 1              
    mov ebx, 0              
    int 0x80