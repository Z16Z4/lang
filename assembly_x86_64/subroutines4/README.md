# Math Operations and the Stack

Math operations are used to mathematically manipulate registers.

The form of a math operation is typically:

operation register, vaule/register

The first register is the subject of the operation. 

For example:

```wasm
add rax, 5
sub rbx, rax
```

so the operation in this case is add, then rax, 5. the vaule of rax is being incremented by 5. 

rbx is being decremented by rax, so rbx would equal rbx - 5

Always assume that the first argument will be the rax register 

![Math%20Operations%20and%20the%20Stack%20c52c8d58fa35483fa13db901e6adf5ef/2021-06-30-191637_1088x580_scrot.png](Math%20Operations%20and%20the%20Stack%20c52c8d58fa35483fa13db901e6adf5ef/2021-06-30-191637_1088x580_scrot.png)

## ASCII

ASCII is the method which modern computers represent strings of text.

Computers can only store numbers, so ASCII works by mapping numbers to specific characters (letters, numbers, symbols, etc).

ASCII uses 7-bit binary codes to represent characters. However, as the byte, which is 8-bit, is the primary unit of information, modern computers usually support extended ASCII, which is 8-bit codes.

It is always useful to reference an ASCII table.

![Math%20Operations%20and%20the%20Stack%20c52c8d58fa35483fa13db901e6adf5ef/2021-06-30-192751_1644x1035_scrot.png](Math%20Operations%20and%20the%20Stack%20c52c8d58fa35483fa13db901e6adf5ef/2021-06-30-192751_1644x1035_scrot.png)

## Display a digit

```wasm
section .data
	digit db 0,10
......
_printRAXDigit:
	add rax, 48
	mov [digit], al
	mov rax, 1
	mov rdi, 1
	mov rsi, digit
	mov rdx, 2
	syscall
	ret
```

Simple code to display a digit within 0 to 9

The digit comes from the rax register 

```wasm
add rax, 48

48 is the vaule of 0 (ASCII)
```

the lower byte of the rax register is then moved into the memory address "digit"

"digit" is actually defined with two bytes, being 0 and 10, a new line character. Since we are only loading the lower byte of the rax register into "digit", it only overwrites the first byte and does not affect the newline character.

al is moved into the memory address [digit] . al just says take the least significant byte. just affects the 0 within digits memory location. rax is going to change meaning everything is effected but the new line character "10"

We then print the two bytes to the screen. This will display the digit as well as the new line character since out length is set to 2.

```wasm
mov rax, 7
call _printRAXDigit
```

you can use this subroutine to display a digit between 0-9 by loading that digit into the rax register then calling the subroutine.

This will display 7 ^

Heres some examples that can be used:

![Math%20Operations%20and%20the%20Stack%20c52c8d58fa35483fa13db901e6adf5ef/2021-06-30-193646_1029x362_scrot.png](Math%20Operations%20and%20the%20Stack%20c52c8d58fa35483fa13db901e6adf5ef/2021-06-30-193646_1029x362_scrot.png)

## The Stack

The stack, like registers, is another way top temporarily store data.

It is called the "stack" because you stack data onto it.

Like a stack of papers, as you stack one paper on top of another, you can only at a given time see the contents of the paper at the top of the stack. 

A page within the middle of the stack cannot be removed without removing all the pages on top of it first, as the pages on top of it hold it in place.

(Super OP btw)

### Terminology

When you add data onto the top of the stack, you push data onto the stack.

When you remove data from the top of the stack, you pop from the stack.

If you look at the top of the stack without removing or adding anything to it, this is called peeking. 

## Stack operations

![Math%20Operations%20and%20the%20Stack%20c52c8d58fa35483fa13db901e6adf5ef/2021-06-30-194658_1009x257_scrot.png](Math%20Operations%20and%20the%20Stack%20c52c8d58fa35483fa13db901e6adf5ef/2021-06-30-194658_1009x257_scrot.png)

Usually in places where you can use registers, you can also use pointers.

Such as, instead of "pop reg", you can use "pop [label] to pop a value off the stack directly into a position in memory.

[rsp] is a stack pointer, it holds the address to the value. pull in the value from that address. can use to peek at the stack.

mov rbx, [rsp] so pop reg

Examples of pushing and popping stack:

![Math%20Operations%20and%20the%20Stack%20c52c8d58fa35483fa13db901e6adf5ef/2021-06-30-194950_1165x584_scrot.png](Math%20Operations%20and%20the%20Stack%20c52c8d58fa35483fa13db901e6adf5ef/2021-06-30-194950_1165x584_scrot.png)

every-time you pop rax, that vaule is stored in the rax register

![Math%20Operations%20and%20the%20Stack%20c52c8d58fa35483fa13db901e6adf5ef/2021-06-30-195055_1189x543_scrot.png](Math%20Operations%20and%20the%20Stack%20c52c8d58fa35483fa13db901e6adf5ef/2021-06-30-195055_1189x543_scrot.png)

every time you push, adds to the stack.

```wasm
push 4
push 8
push 3

pop rax
call _printRAXDigit
pop rax
call _printRAXDigit
pop rax
call _printRAXDigit
```

Out of above example code:

```bash
3
8
4
```

backwards order ^