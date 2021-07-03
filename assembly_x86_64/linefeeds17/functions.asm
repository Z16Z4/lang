;------------------------------------------
; int slen(String message)
; String length calculation function
slen:
    push    rbx
    mov     rbx, rax
 
nextchar:
    cmp     byte [rax], 0
    jz      finished
    inc     rax
    jmp     nextchar
 
finished:
    sub     rax, rbx
    pop     rbx
    ret
 
 
;------------------------------------------
; void sprint(String message)
; String printing function
sprint:
    push    rdx
    push    rcx
    push    rbx
    push    rax
    call    slen
 
    mov     rdx, rax
    pop     rax
 
    mov     rcx, rax
    mov     rbx, 1
    mov     rax, 4
    int     80h
 
    pop     rbx
    pop     rcx
    pop     rdx
    ret
 
 


; void sprintLF(String message)
; String printing with line feed function
 
sprintLF:
	call sprint

	push rax
	mov rax, 0Ah
	push rax
	mov rax, rsp
	call sprint
	pop rax
	pop rax
	ret

; Exit program and restore resources
quit:
    mov     rbx, 0
    mov     rax, 1
    int     80h
    ret
;------------------------------------------
