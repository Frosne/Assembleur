GLOBAL main
EXTERN puts

section .text

main:
	push rbp
	mov rbp, rsp
	mov rdi, message
	call puts
	nop
	pop rbp
	ret

message: db "Miou1", 0	