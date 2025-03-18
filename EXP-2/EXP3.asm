section .data
    LF          EQU     10      
    NULL        EQU     0       
    SYS_WRITE   EQU     4       
    SYS_EXIT    EQU     1       
    STDOUT      EQU     1       

    msg1        db      'Hello, Assembly!', LF, NULL
    msg1_len    EQU     $ - msg1 - 1    
    
    msg2        db      'Using EQU directive', LF, NULL
    msg2_len    EQU     $ - msg2 - 1    

section .text
    global _start

_start:
    mov eax, SYS_WRITE      
    mov ebx, STDOUT         
    mov ecx, msg1          
    mov edx, msg1_len      
    int 0x80

    mov eax, SYS_WRITE     
    mov ebx, STDOUT        
    mov ecx, msg2         
    mov edx, msg2_len     
    int 0x80

    mov eax, SYS_EXIT      
    xor ebx, ebx          
    int 0x80
