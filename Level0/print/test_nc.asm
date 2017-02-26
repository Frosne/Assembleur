GLOBAL main
section .text

main:
print:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, msg_len
	int 80h
exit:	
	mov eax, 1
	int 80h


section .data
	msg db "miou_not_c", 0
	msg_len equ $ - msg