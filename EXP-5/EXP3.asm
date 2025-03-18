%macro read 2
    mov eax, 3         
    mov ebx, 0          
    mov ecx, %1        
    mov edx, %2        
    int 0x80
%endmacro

%macro write 2
    mov eax, 4          
    mov ebx, 1          
    mov ecx, %1        
    mov edx, %2         
    int 0x80
%endmacro

section .data
    prompt db 'Enter a number: '
    prompt_len equ $ - prompt
    msg db 'You entered: '
    msg_len equ $ - msg
    newline db 0xA
    
section .bss
    number resb 10      

section .text
    global _start

_start:
    write prompt, prompt_len    
    read number, 10             
    
    write msg, msg_len        
    write number, 10           
    write newline, 1           
    
    mov eax, 1                 
    mov ebx, 0                 
    int 0x80