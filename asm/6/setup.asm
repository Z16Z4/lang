%include "linux64.inc"
section .data
	text db "Hello, what is your name?", 10 ,0
	text2 db "Hello, ",
	text3 db "Your numbers are"
section .bss
	digitS resb 100
	digitSP resb 8
	name resb 16
section .text
	global _start
	;123 / 10 r 3
	;store 3
	;12 / 10 = 1 r 2
	;store 2
	;1/ 10 = 0 r 1
	;store 1
	;its the number backwards ;)
_start:
	print text
	call _get_name
	print text2
	call _print_name
	print text3
	mov rax, 123
	call _printRAX
	mov rax, 32
	call _printRAX
	mov rax, 60
	mov rdi, 0
	syscall
_printRAX:
	mov rcx, digitS
	mov rbx, 10
	mov [rcx], rbx
	inc rcx
	mov [digitSP], rcx
_printRAXLoop:
	mov rdx, 0
	mov rbx, 10
	div rbx
	push rax
	add rdx, 48
	mov rcx, [digitSP]
	mov [rcx], dl
	inc rcx
	mov [digitSP], rcx
	pop rax
	cmp rax, 0
	jne _printRAXLoop
_printRAXLoop2:
	mov rcx, [digitSP]
	mov rax, 1
	mov rdi, 1
	mov rsi, rcx
	mov rdx, 1
	syscall
	mov rcx, [digitSP]
	dec rcx
	mov [digitSP], rcx
	cmp rcx, digitS
	jge _printRAXLoop2
	ret

_printsub:
	push rax
	mov rbx, 0

_printsubLoop:
	inc rax
	inc rbx
	mov cl, [rax]
	cmp cl, 0
	jne _printsubLoop

	mov rax, 1
	mov rdi, 1
	pop rsi
	mov rdx, rbx
	syscall
	ret
_get_name:
	mov rax, 0
	mov rdi, 0
	mov rsi, name
	mov rdx, 16
	syscall
	ret
_print_name:
	mov rax, 1
	mov rdi, 1
	mov rsi, name
	mov rdx, 16
	syscall
	ret

