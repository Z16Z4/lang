%include 'functions.asm'


SECTION .data
msg1 db 'Hell, brave new world!', 0Ah
msg2 db 'This is how we recycle in NASM.', 0Ah

SECTION .text
global _start

_start:

	mov rax, msg1 ;move string into register
	call sprint ; call print function

	mov rax, msg2 ; move string into register
	call sprint ; call print function

	call quit ; call our quit function
;OUTPUTTED TWICE
;FIXED IN NEXT FILE
