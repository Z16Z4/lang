; A macro with two parameters
; Implements the write system call
   %macro write_string 2 
      mov   rax, 4
      mov   rbx, 1
      mov   rcx, %1
      mov   rdx, %2
      int   80h
   %endmacro
section .bss
	card resb 16 
section	.text
   global _start            ;must be declared for using gcc
	
_start:                     ;tell linker entry point
   write_string poker_table, len4
	;subroutine to get random cards of a stack
   write_string ace_spades, len1               
   write_string one_spades, len2
   call _get_card	;subroutine to get 2 random cards
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

