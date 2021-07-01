# Command line arguments

When a program is executed from the command line, arguments can be passed into it. 

After the name of the program executes, the argument are separated by spaces. 

All arguments are strings, not integers

```bash
./argtest argument1 argument2 argument3
```

## Arguments on the Stack

When the program is executed, the arguments are automatically loaded onto the stack.

The top item is the number of arguments. This number is always at least 1.

The next items in the stack are pointers to the zero-terminated strings starting with the path then of each individual argument.

The path is technically the first argument, and arg[1] is technically the second argument. That because the path is basically arg[0] the kernel fixes this. Arg[2] is the third argument. 

However the operating system provides the *path so *arg[1] is the first user defined argument. 

This is why argc is 1 even if no arguments are specified.

for example, arg[0] is path ./argtest

## Displaying argument count

This code will display the argument count.

It pops the top item off the stack then prints it to the screen. This top item will always be the argument count..

```wasm
%include "linux64.inc"

section .data
	newline db 10,0
section .text
	global _start
_start:
	pop rax
	printVal rax
	print newline
	exit
```

argtest.asm will display an argument count followed by all the arguments inputted into the program.

## Why arguments?

Arguments allow the user to input data into a program without the program requiring a user interface.

This can also be used to link the output of one command line application to the input of your command line application.

Notice how the output file list from the "ls" command is fed into argtest.