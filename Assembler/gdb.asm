section .text
global _start

_start:
xor eax, eax
push eax

mov eax, 0
mov ebx, 1
int 80h

