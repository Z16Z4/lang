# hello_world.asm breakdown

### Hello_world.asm

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

> text db "Hello world", 10

### What is db ?

db stands for define bytes. It essentially means that we are going to define some raw bytes of data to insert into our code

> "Hello world"

this is the data that we are defining. each character in the string is a single byte. The "10" is a newline character, which i often denote as "\n"

> text

This is a name assigned to the address in memory that this data is located in. Whenever we use "text" later in the code, when the code is compiled. The compiler will determine the actual location in memory of this data and replace all future instances of "text" with that memory address. 

> text db "Hello world", 10

So "text" is the name of the memory location, with "db" we are saying define these bytes to that memory location "text", then "Hello world" ,10 are the bytes that we are defining. In this example we are defining 14 bytes into "text" since each character is a byte of memory.

## Registers

registers are a part of the processor that temporarily holds memory. In x86_64 architecture, registers hold 64-bits. 

This means each register can hold the vaules:

0 to 18,000,000,000,000,000,000, Unsigned bytes

and -9,000,000,000,000,000,000 - 9,000,000,000,000,000,000 Signed bytes of data 

Registers hold integer vaules, so whole numbers:

![hello_world%20asm%20breakdown%204fae5f8d40154500931268bd5129ebdb/2021-06-30-160343_1226x640_scrot.png](hello_world%20asm%20breakdown%204fae5f8d40154500931268bd5129ebdb/2021-06-30-160343_1226x640_scrot.png)

This is what a register would look like:

64-bit registers use a rax register, 32bit programs would use halve the register. AL register would act as a 8-bit register, doesn't mean a 8-bit program would be only compatible with a 8-bit register 

## Syscall

A system call, or a syscall, is when a program requests a service from the kernel. 

System calls will differ by operating system because different operating systems use different kernels.

All syscalls have an ID associated with them (A number)

Syscalls also take arguments, meaning, a list of inputs. 

![hello_world%20asm%20breakdown%204fae5f8d40154500931268bd5129ebdb/2021-06-30-160706_1117x632_scrot.png](hello_world%20asm%20breakdown%204fae5f8d40154500931268bd5129ebdb/2021-06-30-160706_1117x632_scrot.png)

This is a table you should try to remember, when you use a syscall it has a number of inputs, and the inputs are based on the vaules stored in the registers. For example, the ID for the syscall in stored in the rax register, the first argument would be within the rdi register, and the second in the rsi register and so on...

If you want to use a syscall, you would load the ID into the rax register, then load your arguments through 1 -6 in the other registers. then you would use your syscall.

Heres a syscall list to look at, there are many different types of syscalls to interact with the kernel:

![hello_world%20asm%20breakdown%204fae5f8d40154500931268bd5129ebdb/2021-06-30-161318_1232x579_scrot.png](hello_world%20asm%20breakdown%204fae5f8d40154500931268bd5129ebdb/2021-06-30-161318_1232x579_scrot.png)

So for example if we wanted to use the syscall sys_read, to read... we would load in ID 0 into the rax register, rdi would hold the #filedescriptor, ARG 2 would be held by the rsi register and arg 3 would be held by the rdx register. 

Another example would be sys_write, this is what was used to write hello world:

![hello_world%20asm%20breakdown%204fae5f8d40154500931268bd5129ebdb/2021-06-30-162011_1199x595_scrot.png](hello_world%20asm%20breakdown%204fae5f8d40154500931268bd5129ebdb/2021-06-30-162011_1199x595_scrot.png)

If we update the hello world .asm code, we clearly see where the sys_write syscall was used:

```wasm
section .data
	text db "Hello world", 10

section .text
	global _start

_start:
	mov rax, 1 ; using the sys_write syscall
	mov rdi, 1 ; argument 1 is standard output 
	mov rsi, text ; argument 2 is the location of the strings to write
	mov rdx, 14 ; argument 4 is the count, so Hello world has the length of 14
	syscall

	mov rax, 60
	mov rdi, 0
	syscall
```

So what about rax, 60 and rdi, 0 ?

Well the sys_exit syscall was used to exit the program. telling the kernel that we have finished running the code:

The sys_exit id is 60, so this was loaded into the rax register, the first argument that sys_exit takes is #error code. since this is the first argument of this syscall it would be stored in the rdi register. and the error code we want to use is 0 (exit with no error). We can decide what this error code is, it could be 404 for example.. etc

```wasm
section .data
	text db "Hello world", 10

section .text
	global _start

_start:
	mov rax, 1 ; using the sys_write syscall
	mov rdi, 1 ; argument 1 is standard output 
	mov rsi, text ; argument 2 is the location of the strings to write
	mov rdx, 14 ; argument 4 is the count, so Hello world has the length of 14
	syscall

	mov rax, 60 ; using the sys_exit syscall
	mov rdi, 0 ; error code argument 1 set to 0
	syscall
```

So overall the code after complete labeling with whats been learnt, we know that:

```wasm
section .data
	;using memory location text
	text db "Hello world", 10 ;defined bytes as string

section .text
	global _start

_start:
	mov rax, 1 ; using the sys_write syscall
	mov rdi, 1 ; argument 1 is standard output 
	mov rsi, text ; argument 2 is the location of the strings to write
	mov rdx, 14 ; argument 4 is the count, so Hello world has the length of 14
	syscall

	mov rax, 60 ; using the sys_exit syscall
	mov rdi, 0 ; error code argument 1 set to 0
	syscall
```

## Sections

In asm their are different sections, for example we have the section .data, the .bss section and .text section. In the example above only the .data and .text section were used. Thats because the:

section .data , is where all data is defined before compilation (defining bytes)

section .text is where the actual code goes.

and section .bss is where data is allocated for future use. hence why it wasn't used in this example

## Labels

A "label is used to label a part of code

when compiling, the compiler will calculate the location in which the label will sit in memory. 

Any time the name of the label is used afterwards, that name is replaced by the location in memory by compiler. The label used within this code was the _start label.

The _start label used is essential for all programs. When your program is compiled and later executed, it is executed first at the location of _start

If the linker cannot find "_start" it will throw an error.

## Global

the world "global" is used when you want the linker to be able to know the address of a label

The object file generated will contain a link to every label declared "global"

In this case, we have to declare "_start" as global since it is required for the code to be properly linked.
