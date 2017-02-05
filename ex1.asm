section .text
global _start

_start:

push msg ; x; push -> Stack[x] = msg; st = x +4
push byte 'd' ; push -> Stack[x+4] = 'd' st = x+8
call fun ; push eip st = x+12 push ebp => sp = x+16
add esp, 8
mov eax, 1
mov ebx, 1
int 80h




fun:
push ebp
mov ebp, esp

mov edi, [ebp+8]
mov edx, edi
xor eax, eax
or ecx, 0FFFFFFFh
repne scasb
add ecx, 2
neg ecx
mov al, [ebp+0Ch]  
mov edi, edx
rep stosb
mov eax, edx

mov esp, ebp
pop ebp
ret

section .data
msg db "helloworld", 0xa
msglen equ $-msg
