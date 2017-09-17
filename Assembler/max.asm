section     .text
global      _start                              ;must be declared for linker (ld)

_start:                                         ;tell linker entry point

    mov     cl, [lst]
    mov     edi, 1
    
loop_:    
    mov     bl, [lst + edi]
    cmp     cl, bl
    jg nextloop
    mov cl, bl
    
nextloop:
    cmp edi, lenlist
    jg print
    add edi, 1
    jmp loop_
    
print:     
    mov     edx,1                            ;message length
    mov     ecx,msg                            ;message to write
    mov     ebx,1                               ;file descriptor (stdout)
    mov     eax,4                               ;system call number (sys_write)
    int     0x80  ;call kernel
    jmp exit
    
    
exit:
    mov     eax,1                               ;system call number (sys_exit)
    int     0x80                                ;call kernel

section     .data

msg     db  'Hello, world!',0xa                 ;our dear string
len     equ $ - msg                             ;length of our dear string
lst     db  1,2,3
lenlist equ $ - lst
