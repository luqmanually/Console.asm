section .data ; section to store data
    message: dd "Hello, World!"
    ask: dd "Whats your name: "
    greet: dd "Hello, "
    newline: db 10 ; Newline

section .bss ; section that stores uninitliased data
    input: resb 16

section .text ; code section
    global _start
    _start: ; main code goes in here

        mov rax, message ; set rax register to message
        call _console_out ; call the _console_out subroutine to print out message
        call _console_space ; go to newline

        mov rax, ask
        call _console_out

        call _console_get ; call the _console_get subroutine to get the console input, input stored in input variable in .bss

        mov rax, greet
        call _console_out

        mov rax, input ; set rax register to input
        call _console_out ; print out rax

        call _exit ; calls _exit subroutine to properly end, avoid segmentation fault

_console_out:
    ; subroutine to print out the message stored in rax
    push rax
    mov rbx, 0
    message_len_loop:
        ; increase pointer for the message and count
        inc rax
        inc rbx
        mov cl, [rax] ; load byte to memory address
        cmp cl, 0 ; check for null terminator
    jne message_len_loop
 
    ; print out message
    mov rax, 1
    mov rdi, 1
    pop rsi ; retrive original memory address from stack into rsi
    mov rdx, rbx ; length of message to print
    syscall
    ret ; return to code/end of subroutine

_console_space:
    ; subroutine to print out new line
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall
    ret ; end of subroutine

_console_get:
    ; subroutine that fetches input
    mov rax, 0
    mov rdi, 0
    mov rsi, input ; rbx is where the input will be stored
    mov rdx, 256 ; 256 bytes allocation
    syscall
    ret ; end of subroutine

_exit:
    ; subroutine to quit code. required, otherwise segmentation fault.
    mov rax, 60
    mov rdi, 0
    syscall
    ret ; end of subroutine