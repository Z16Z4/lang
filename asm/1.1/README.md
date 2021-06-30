# Jumps, Calls, Comparisons

## Flags

Flags, like registers, hold. data 

Flags only hold 1 bit each. they are either true or false

Individual flags are part of a larger register. 

[Flags](https://www.notion.so/89b3583fc96e4696ba6f12a0384dcdb9)

## Pointers

Pointers are also registers that hold data. 

They "point to" data, meaning, they hold its memory address.

[Pointers](https://www.notion.so/f34b64cd3388415488f6f3b0b26e2a48)

Doesn't hold its value just its address to locate it. rip version for 64 bit

## Control Flow

All code runs from top to bottom by default. The direction a program flows is called the control flow.

The rip register holds the address of the next instruction to executed. After each instruction, it is incremented by 1, (essentially) making the control flow naturally flow from top to bottom 

![Jumps,%20Calls,%20Comparisons%2080e52cd32d3946b389c68ae54f3fc53e/2021-06-30-174055_453x387_scrot.png](Jumps,%20Calls,%20Comparisons%2080e52cd32d3946b389c68ae54f3fc53e/2021-06-30-174055_453x387_scrot.png)

## Jumps

Jumps can be used to jump to different parts of code based on labels. They are used to divert program flow.

The general format of the jump is:

```wasm
jmp label ; loads the vaule "label" into rip register
```

![Jumps,%20Calls,%20Comparisons%2080e52cd32d3946b389c68ae54f3fc53e/2021-06-30-174320_1023x170_scrot.png](Jumps,%20Calls,%20Comparisons%2080e52cd32d3946b389c68ae54f3fc53e/2021-06-30-174320_1023x170_scrot.png)

You can change the control flow of the program using jmp, would change to a circle, stuck in a infinite loop using this example. 

Basically reloading the _start

## Comparisons

Comparisons allow programs to be able to take different paths based on certain conditions. 

Comparisons are done on registers. 

The general format of a comparison is..

```wasm
cmp register, register/vaule

for example :

cmp rax, 23
cmp rax, rbx
```

In the above example the rax register is being compared against the number 23

And then the rax register is being compared to the rbx register 

## Comparisons with flags

After a comparison is made certain flags are set

![Jumps,%20Calls,%20Comparisons%2080e52cd32d3946b389c68ae54f3fc53e/2021-06-30-174751_1074x269_scrot.png](Jumps,%20Calls,%20Comparisons%2080e52cd32d3946b389c68ae54f3fc53e/2021-06-30-174751_1074x269_scrot.png)

If a = b then ZF (zero flag) is set = 1

## Conditional Jumps

After a comparison is made, a conditional jump can be made.

Conditional jumps are based on the status of the flags.

Conditional jumps are based on the status of the flags.

Conditional jumps in code are written just like unconditional jumps, however "jmp" is replaced by the symbol for the conditional jump.

So after an comparison a flag is set and then a conditional jump can be made based of the status of the flag. 

![Jumps,%20Calls,%20Comparisons%2080e52cd32d3946b389c68ae54f3fc53e/2021-06-30-175131_1006x641_scrot.png](Jumps,%20Calls,%20Comparisons%2080e52cd32d3946b389c68ae54f3fc53e/2021-06-30-175131_1006x641_scrot.png)

So for example, if a and b are compared. then the "je" jump symbol will be used. 

By default everything is signed

## Conditional Jump examples

```wasm
cmp rax, 23
je _doThis
```

This code will jump to the address of label "_doThis" if and only if the vaule in the rax register equals 23.

```wasm
cmp rax, rbx
jg _doThis
```

This code will jump to the address of label "_doThis" if and only if the vaule in the rax register is greater than the value in the rbx register 

## Registers as Pointers

The default register can be treated as pointers.

To treat a register as a pointer, surround the register name with square brackets, such as, "rax" becomes "[rax]".

```wasm
mov rax, rbx
```

This code loads the value in the rbx register into the rax register ^

```wasm
mov rax, [rbx]
```

This loads the value the rbx register is pointing to into the rax register

## Calls

Calls and jumps are essentially the same. However when "call" is used , the original position the call was made ca be returned to using "ret"

```wasm
section .data
	text db "Hello, world", 10
section .text
	global _start

	call _printHello
	mov rax, 60
	mov rdi, 0
	syscall
_printHello:
	mov rax, 1
	mov rdi, 1
	mov rsi, text
	mov rdx, 14
	syscall
	ret
```

In this modification of the "hello_world.asm" code, the part of code that prints "Hello world" was moved into its own section, and that section was called _printHello

This is called a subroutine!