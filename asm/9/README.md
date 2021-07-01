# Reading files

sys_open

here is the code to open a file with the "Read only" flag

```wasm
mov rax, SYS_OPEN
mov rdi, filename
mov rsi, O_RDONLY
mv rdx, 0644o
syscall
```

![Reading%20files%208b2e265984ff4bc29350f0c0e5184326/Screenshot_2021-07-01-48_849x440.png](Reading%20files%208b2e265984ff4bc29350f0c0e5184326/Screenshot_2021-07-01-48_849x440.png)

This system call returns the file descriptor of the file opened within the rax register. 

If there is an error, that error is returned in the rax register

## Sys_read

This system call can be used to read text from a file.

It is used exactly like how we used it to get user input. The only difference is that the first argument is chnaged to the file descriptor returned from the sys_open system call

Heres the code to read from an opened file:

```wasm
mov rdi, rax
mov rax, SYS_READ
mov rsi, text
mov rdx, 17
syscall
```

![Reading%20files%208b2e265984ff4bc29350f0c0e5184326/Screenshot_2021-07-01-03_852x421.png](Reading%20files%208b2e265984ff4bc29350f0c0e5184326/Screenshot_2021-07-01-03_852x421.png)

sys_close only takes the file descriptor as an argument

```wasm
mov rax, SYS_CLOSE
pop rdi
syscall
```

Code to open a file, read from a file then close the file

```wasm
%include "linux64.inc"
section .data
	filename db "myfile.txt",0
section .bss
	text resb 18
section .text
	global _start
_start:
	;open the file
	mov rax, SYS_OPEN
	mov rdi, filename
	mov rsi, O_RDONLY
	mov rdx, 0
	syscall
	;read from the file
	push rax
	mov rdi, rax
	mov rax, SYS_READ
	mov rsi, text
	mov rdx, 17
	syscall
	;close the file
	mov rax, SYS_CLOSE
	pop rdi
	syscall

	print text
	exit
```