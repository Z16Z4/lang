SECTION .data
msg db 'Hello brave new world!', 0Ah

SECTION .text
global _start

_start:

	mov rax, msg ;move message to rax
	call strlen ;call function, calculate string length

	mov rdx, rax ;our function leaves the result in rax
	mov rcx, msg
	mov rbx, 1
	mov rax, 4
	int 80h

	mov rbx, 0
	mov rax, 1
	int 80h


strlen:
	push rbx	;this is our first function
	mov rbx, rax	;push the vaule in rbx onto the stack
			;to preserve it while we use
			;rbx in this function 

nextchar:
	cmp byte [rax],0
	jz finished
	inc rax
	jmp nextchar

finished:
	sub rax, rbx
	pop rbx ;pop the vaule on the stack bac into rbx
	ret	;return to whre the function was called


