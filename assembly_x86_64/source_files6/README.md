# Macros

Macros only work on nasm, net wide assembler 

A Macro is a single instruction that expands into a predefined set of instructions to perform a particular task

for example, the macro exit could be 

```bash
mov rax, 60
mov rdi, 0
syscall
```

This is SYS_EXIT ^

You can define a macro like so:

```bash
%macro <name> <argc>
	...
	<macro body>
	...
%endmacro
```

The name of the macro, the number of arguments the macro will take

for example the exit macro would look like this:

```bash
%macro exit 0
	mov rax, 60
	mov rdi, 0
	syscall
%endmacro
```

0 is the argc the argument that the macro takes 

## Arguments

<argc> is the number of arguments the macro takes. arguments are inputs that can be passed into the macro. 

Within the macro body, these inputs are referenced using "%1" for the first input, "%2" for the second input, etc. 

## Print digit macro

a print digit macro would look like this 

```wasm
%macro exit 0
	mov rax, 0
	mov rdi, 0
	syscall
%endmacro

%macro printDigit 1
	mov rax, %1
	call _printRAXDigit
%endmacro
_start:
	printDigit 3
	printDigit 4
	exit
```

For the "printDigit" macro, argc is 1 because it takes 1 argument (a digit)

for the exit macro, argc is 0 because it takes no arguments. 

When we use "printDigit" in code under _start, we specify a number after it, that is our first argument. 

When we use "exit" we specify no numbers after it because it takes no argument. 

If the about of arguments you have is greater then 1 , then a comma is used between inputs:

```wasm
&macro printDigitSum 2
	mov rax, %1
	add rax, %2
	call _printRAXDigit
%endmacro

_start:
	printDigitSUm 3, 2
	exit
```

This code will print 5

Macros are expanded upon compilation into predefined code.

If that code contains a label, this can cause duplicate label error if the macro is used more than once. 

## Local Labels in Macros

```wasm
%macro freeze 0
_loop:
	jmp _loop
%endmacro
_start:
	freeze
	freeze
	exit
```

duplicate label error

This code above is solved by using "%%" before label names within a macro. 

This will make it so that the label is unique every time it is expanded. 

```wasm
%macro freeze 0
%%loop:
	jmp %%loop
%endmacro
```

## Defining Values with EQU

EQU is used for defining constants for future use. 

For example:

```wasm
section .data 
	text db "Hello world", 10
section .text
	global _start
_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, text
	mov rdx, 14
	syscall

	mov rax, 60
	mov rdi, 0
	syscall

```

Can become...

```wasm
STDIN equ 0
STDOUT equ 1
STDERR equ 2
SYS_READ equ 0
SYS_WRITE equ 1
SYS_EXIT equ 60
section .data
	text db "Hello world", 10
section .text
	global _start
_start:
	mov rax, SYS_WRITE
	mov rdi, STDOUT
	mov rsi, text
	mov rdx, 14

	mov rax, SYS_EXIT
	mov rdi, 0
	syscall

```

## Including External Files

A single assembly program can be broken up into multiple files by using "include".

"Include" will load an external files code and insert it into the position in which it is included upon compilation.

Macros and EQU definitions are often defined inside of included files. 

```wasm
%include "filename.asm"
```