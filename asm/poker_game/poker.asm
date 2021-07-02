   %macro write_string 2 
      mov   rax, 4
      mov   rbx, 1
      mov   rcx, %1
      mov   rdx, %2
      int   80h
   %endmacro
   %macro rand_num 2
   ;HOW DID BOOMERS GENERATE RAND NUMBERS
	xor     rdx, rdx             ;there's no division of EAX solely
	mov     rcx, %1 - %2 + 1   ; 117 possible values
	div     rcx                  ; EDX:EAX / ECX> EAX quotient, EDX remainder
	mov     rax, rdx             ; -> EAX = [0,116]
	add     rax, 162             ; -> EAX = [162,278]
	and	rax, -2
	int 80h
   %endmacro
section .bss
	card resb 16 
	digitS resb 100
	digitSP resb 8
	printSpace resb 8
section	.text
   global _start            ;must be declared for using gcc
	
_start:                     ;tell linker entry point
   write_string poker_table, len4
	;subroutine to get random cards of a stack
   write_string ace_spades, len1               
   write_string one_spades, len2
   rand_num 104, 52
   call _printRAX
   call _get_card	;subroutine to get 2 random cards
   rand_num 104, 23
   call _printRAX
   write_string select_card, len0
   write_string card, 16
   mov rax,1                ;system call number (sys_exit)
   int 0x80                 ;call kernel
_get_card:
	mov rax, 0
	mov rdi, 0
	mov rsi, card
	mov rdx, 16
	syscall
	ret
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

section	.data
;could use an array here
poker_table db "--------Poker Table--------",0XA,0XD
len4 equ $- poker_table
select_card db "Your card is "
len0 equ $- select_card
ace_spades db 'Ace of spades',0xA,0xD 	
len1 equ $- ace_spades			
one_spades db '1 of spades',0XA,0XD
len2 equ $- one_spades
two_spades db '2 of spades',0xA,0XD
len3 equ $- two_spades

