# Nanosleep

db dw dd dq

"db" is used to "define bytes" and how it can be used to define bytes of data. A "byte" is 8 bits, ranging from 0 to 255 (or -128 to 127)

```wasm
section .data 
	somedata db 5
```

A "Word" is a certain number of bytes arising from the processor's design.

For x86_64 processors, a "word" is equal to 2 bytes, or 16-bits. A "dword" or "double word" is 4 -bytes, or 32 bits, and a "qword" "quadruple word" is 8 bytes or 64 bits

These can be defined using "dw", "dd", and "dq"

db -define bytes

dw - define word

dd - define double word

dq define quadruple word

## timespec

"Timespec" is a structure which holds two vaules, tv_sec and tv_nsec.

tv_Sec and tv_nsec are both 64-bit integer vaules, in other words, they are qwords.

The max vaule for tv_nsec is 999,999,999 because 1 second = 1,000,000,000 nanoseconds.

## Sys_nanosleep

This system call can be used to suspend a program for a certain amount of time. 

It is called "nanosleep" because its precision is down to nanoseconds.

The two arguments are both pointers to timespec vaules

The first argument is the length of the delay, the second is often just left blank (rsi is set to 0)

This code will sleep for 5 seconds and 5000,000,000 nano seconds, or , 5.5 seconds.

After 5.5 seconds, the program will end

```wasm
section .data 
;five seconds, and 5000000000 nano seconds
	delay dq 5, 5000000000
section .text
	global _start
_start:
	mov rax, 35
	mov rdi, delay ;load pointer into rdi
	mov rsi, 0 ;set to 0
	syscall ; call it 

	mov rax, 60
	mov rdi, 0
	syscall

```

the delay, the first value is tv_sec

the second value is tv_nsec