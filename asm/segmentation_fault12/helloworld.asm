SECTION .data
msg	db	'Hello World', 0Ah

SECTION .text
global _start

_start:
	mov	rdx,	13
	mov	rcx,	msg
	mov	rbx,	1
	mov	rax,	4
	int	80h



;Segmentation Fault
	
