# Writing Files

## sys_open

The first argument sys_open takes is a pointer to the filename (zero terminated)

The second argument are the flags.

The third argument is file mod, being the 4-digit octal number that we learned from earlier.

syscall | id | arg1 | arg 2 | arg 3

sys_open | 2 | $filename | #flags | #mode

![Writing%20Files%20de0c7b9ba6214cb2bd584b72345b7773/Screenshot_2021-07-01-17_780x413.png](Writing%20Files%20de0c7b9ba6214cb2bd584b72345b7773/Screenshot_2021-07-01-17_780x413.png)

Here is the code to open a file with the "create" and "write" flag.

The "create" flag creates the file if it does not exist

```wasm
mov rax, SYS_OPEN
mov rdi, filename
mov rsi, 0_CREAT+0_WRONLY
mov rdx, 06644o
syscall

```

![Writing%20Files%20de0c7b9ba6214cb2bd584b72345b7773/Screenshot_2021-07-01-49_859x447.png](Writing%20Files%20de0c7b9ba6214cb2bd584b72345b7773/Screenshot_2021-07-01-49_859x447.png)

This system call returns the file descriptor of the file opened within the rax registers.

If there is an error, that error is returned in the rax register.

## sys_write

This system call can be used to write text to a file 

It is used exactly like how we used it in the "Hello world" to display text on the screen. The difference is that the first argument is changed to the file descriptor returned from the sys_open system call

![Writing%20Files%20de0c7b9ba6214cb2bd584b72345b7773/Screenshot_2021-07-01-53_859x476.png](Writing%20Files%20de0c7b9ba6214cb2bd584b72345b7773/Screenshot_2021-07-01-53_859x476.png)

sys_close only takes the file descriptor as its only argument 

sys_close 

mov rax, SYS_CLOSE

pop rdi

syscall

![Writing%20Files%20de0c7b9ba6214cb2bd584b72345b7773/Screenshot_2021-07-01-53_859x476%201.png](Writing%20Files%20de0c7b9ba6214cb2bd584b72345b7773/Screenshot_2021-07-01-53_859x476%201.png)