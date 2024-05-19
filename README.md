# Console.asm

**Assembled using the [NASM](https://www.nasm.us/) assembler, x86 64-bit.**

## Available functions

Please note that the code examples shown below are only to demostrate the usage of the subroutines, and may not necessarily include all the required script, variables and subroutines to create a functioning program.

### `_console_get`

Console read mode, input value is stored in the `value` variable, inside `section .bss`.

Example usage:

```asm
.section data
    message: dd "What is your name: "
.section text
    ; using the _console_out subroutine to print the message
    mov rax, message            ; store message in rax register
    call _console_out           ; call the subroutine to print out the message

    ; reading the input from the console
    call _console_get           ; call the subroutine to read the input
    mov rax, input              ; store the input in rax register
    call _console_out           ; call the subroutine to print out the input
```

### `_console_out`

Prints out a message (stored in the `rax` register) to the console, **creation** of a new line.

Example usage:

```asm
.section data
    message: dd "Hello, world!" ; message to be printed
.section text
    mov rax, message            ; store message in rax register
    call _console_out           ; call the subroutine
```

### `_console_space`

Moves the console to a new line.

Example usage:

```asm
.section data
    message: dd "Enter your name: " ; mess
```

### `_exit`

Exits the program.

```asm
call _exit
```
