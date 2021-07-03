SECTION .data
msg db 'Hello, brave new world!', 0Ah

SECTION .text
global _start


_start:
	mov rbx, msg ;move the address of our message string to rbx
	mov rax, rbx ;move address rbx->rax, points to the same location in memory


nextchar:
;compare the byte pointed to by rax at this
;address against zero	
;jump (if the zero flagged has been set)
;increment the address in rax by one byte if the zero flag hasnt
;been set
;jump to the point in the code labeled 'nextchar'
	cmp byte[rax],0
	jz finished
	inc rax
	jmp nextchar
finished:
	sub rax, rbx ;subtract the address in RBX from
		     ;the address in RAX

	mov rdx, rax
	mov rcx, msg
	mov rbx, 1
	mov rax, 4
	int 80h


	mov rbx, 0
	mov rax, 1
	int 80h

