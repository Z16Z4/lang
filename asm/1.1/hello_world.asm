section .data 
	text db "Hello world", 10

section .text
	global _start

	call _printHello
	mov rax, 60 ;sys_exit
	mov rdi, 0 ;error code 0
	syscall

_printHello:
	;subroutine
	mov rax, 1 ;sys_write
	mov rdi, 1
	mov rsi, text
	mov rdx, 14
	syscall
	ret

