	global main
   %macro write_string 2 ; to print strings
      mov   rax, 4		 ;sys write
      mov   rbx, 1
      mov   rcx, %1		 ; sys write first argument
      mov   rdx, %2		 ; sys write second argument
      int   80h			 ; system call
   %endmacro
   %macro rand_num 2	;to generate rand number
	xor     rdx, rdx             ;No division
	mov     rcx, %1 - %2 + 1     ;generate rand seed
	div     rcx                  ; rdx:rax/ rcx> rax quotient, rdx remainder
	mov     rax, rdx             ; -> etc rax = [0,116]
;	add     rax, 162             ; -> etc rax = [162,278]
	add rax, 2					 ; add 2 to rax
	and	rax, -2					 ; and rax-2
	int 80h						 ;syscall
   %endmacro
   %macro get_card_num 1	;to get last bits of rand num
	rand_num 150,50			; use macro rand , with seeds
	mov [%1], al			; move last bits into argument
	mov rax, %1				; move arugment into rax register
	sub rax, rcx			;subtract rax by rcx
	int 80h
   %endmacro
section .bss
	digitS resb 100			;digit space to print int 
	digitSP resb 8			;position of digit
	cardPos1 resb 4			;card position 1 on board
	cardPos2 resb 4			;card position 2 on board
	cardPos3 resb 4			;card position 3 on board
	cardPos4_river resb 4	;river card position 4
	cardPos5_river resb 4	;river card position 5
section	.text
   global _start            ;must be declared for using nasm x86
true1:
	write_string ace_spades, len1		;jmp to print ace_spades
	jmp pos2							;return to position 2
true2:
	write_string one_spades, len2		;jmp to print one_spades
	jmp pos3							;return to position 3
	
_start:
	write_string poker_table, len4		;Poker table heading
main:
	jmp pos1
pos1:
	get_card_num cardPos1				;gen rand in cardPos1
	mov rax, cardPos1					;move cardPos1 to rax
	call _sub_rand						;remove uneeded vaules
	cmp rax,[ace_spade]					;Is this == ace_spade (53)
	je true1							;if it is jump to true1 to print
	jmp out_of_range					;otherwise out of range (increment)
	jmp pos1
	;call _printRAX						;otherwise print vaule
	mov rax, 1
	int 0x80
pos2:
	get_card_num cardPos2 ;generate rand num
	mov rax, cardPos2 ; mov card2 into rax
	call _sub_rand ; remove addition num

	cmp rax,[ace_club] ;compare 52 deck
	jg out_of_range ; if more then 
range1:
	cmp rax,[one_spade]
	je true2
	call _printRAX
	jmp pos3
	mov rax, 1
	int 0x80
pos3:
	get_card_num cardPos3
	mov rax, cardPos3
	call _sub_rand
	call _printRAX
	jmp pos4
	mov rax, 1
	int 0x80
	
	write_string river, lenriver
pos4:
	get_card_num cardPos4_river
	mov rax, cardPos4_river
	call _sub_rand
	call _printRAX
	jmp pos5
	mov rax, 1
	int 0x80
pos5:
	get_card_num cardPos5_river
	mov rax, cardPos5_river
	call _sub_rand
	call _printRAX	
	mov rax,1                ;system call number (sys_exit)
	int 0x80                 ;call kernel

out_of_range:
	sub rax, 1
	cmp rax,[king_spade]
	jg out_of_range
	ret

_sub_rand:
	sub rax, 4202700
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


;The river string 

river db ".. on the river ...",0XA,0XD
lenriver equ $- river


;Cards of Clubs
;---------------
one_clubs: dq 1
two_clubs: dq 2
three_clubs: dq 3
four_clubs: dq 4
five_clubs: dq 5
six_clubs: dq 6
seven_clubs: dq 7
eight_clubs: dq 8
nine_clubs: dq 9
ten_clubs: dq 10
jack_clubs: dq 11
queen_clubs: dq 12
king_clubs: dq 13
;Cards of Diamond
;-----------------
one_diamond: dq 14
two_diamond: dq 15
three_diamond: dq 16
four_diamond: dq 17
five_diamond: dq 18
six_diamond: dq 19
seven_diamond: dq 20
eight_diamond: dq 21
nine_diamond: dq 22
ten_diamond: dq 23
jack_diamond: dq 24
queen_diamond: dq 25
king_diamond: dq 26
;Cards of Hearts
;----------------
one_heart: dq 27
two_heart: dq 28
three_heart: dq 29
four_heart: dq 30
five_heart: dq 31
six_heart: dq 32
seven_heart: dq 33
eight_heart: dq 34
nine_heart: dq 35
ten_heart: dq 36
jack_heart: dq 37
queen_heart: dq 38
king_heart: dq 39

;Cards of Spades
;---------------
one_spade: dq 40
two_spade: dq 41
three_spade: dq 42
four_spade: dq 43
five_spade: dq 44
six_spade: dq 45
seven_spade: dq 46
eight_spade: dq 47
nine_spade: dq 48
ten_spade: dq 49
jack_spade: dq 50
queen_spade: dq 51
king_spade: dq 52

;aces
ace_spade: dq 53
ace_heart: dq 54
ace_diamond: dq 55
ace_club: dq 56
