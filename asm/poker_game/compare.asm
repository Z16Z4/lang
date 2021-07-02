	global	main		; define for linker
        section .data		; Data section, initialized variables
a:	dq 1
b:	dq 2
c:	dq 3
fmt1:   db "true a < b ",10,0
len1 equ $- fmt1
fmt2:   db "wrong on a < b ",10,0
len2 equ $- fmt2
fmt3:   db "wrong on b > c ",10,0
len3 equ $- fmt3
fmt4:   db "false b > c ",10,0
len4 equ $- fmt4
	section .text
main:	push	rbp		; set up stack
	mov	rax,[a]		; a
	cmp	rax,[b]		; compare a to b
	jge	false1		; choose jump to false part
	; a < b sign is set
        mov	rdi, fmt1	; printf("true a < b \n"); 
        call    _print_text1	
        jmp	exit1		; jump over false part
false1:	;  a < b is false 
        mov	rdi, fmt2	; printf("wrong on a < b \n");
        call    _print_text2
exit1:				; finished 'if' statement

	mov	rax,[b]		; b
	cmp	rax,[c]		; compare b to c
	jle	false2		; choose jump to false part
	; b > c sign is not set
        mov	rdi, fmt3	; printf("wrong on b > c \n");
        call    _print_text3
        jmp	exit2		; jump over false part
false2:	;  a < b is false 
        mov	rdi, fmt4	; printf("false b > c \n");
        call    _print_text4
exit2:				; finished 'if' statement

	pop	rbp		; restore stack
	mov	rax,0		; normal, no error, return value
	ret			; return 0;
_print_text1:
	mov rax, 1
	mov rdi, 1
	mov rsi, fmt1
	mov rdx, len1
	syscall
	ret
_print_text2:
	mov rax, 1
	mov rdi, 1
	mov rsi, fmt2
	mov rdx, len2
	syscall
	ret
_print_text3:
	mov rax, 1
	mov rdi, 1
	mov rsi, fmt3
	mov rdx, len3
	syscall
	ret
_print_text4:
	mov rax, 1
	mov rdi, 1
	mov rsi,fmt4
	mov rdx, len4
	syscall
	ret
