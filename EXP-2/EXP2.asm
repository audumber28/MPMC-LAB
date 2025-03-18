section .data
    stars times 9 db '*'    
    newline db 10
section .text
    global _start
_start:
    mov eax, 4    
    mov ebx, 1    
    mov ecx, stars
    mov edx, 9
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80


    mov eax, 1              
    xor ebx, ebx            
    int 0x80