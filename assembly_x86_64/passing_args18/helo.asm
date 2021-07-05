%include 'functions.asm'


SECTION .text
global _start

_start:
	pop rcx
next:
	cmp rcx, 0h
	jz nomore
	pop rax
	call sprintLF
	dec rcx
	jmp next
nomore:
	call quit
