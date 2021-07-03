SECTION .data
msg db 'Hello world, no segmentation fault', 0Ah

SECTION .text
global _start


_start:
	mov rdx,13
	mov rcx, msg
	mov rbx, 1
	mov rax, 4
	int 80h

	mov rbx,0 ;return 0 status on exit 'No errors'
	mov rax,1 ; invoke sys_exit
	int 80h

