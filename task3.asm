section .data
    prompt db "Enter a number: ", 0
    result_msg db "Factorial: ", 0
    newline db 10, 0              ; Newline character for output formatting

section .bss
    num resb 1                   ; Buffer to store input number
    result resb 20               ; Buffer to store the result string (max 20 digits)

section .text
    global _start

; Entry point
_start:
    ; Display prompt
    mov eax, 4                   ; Syscall number for sys_write
    mov ebx, 1                   ; File descriptor (stdout)
    mov ecx, prompt              ; Address of the prompt
    mov edx, 15                  ; Length of the prompt
    int 0x80                     ; Make syscall

    ; Read user input
    mov eax, 3                   ; Syscall number for sys_read
    mov ebx, 0                   ; File descriptor (stdin)
    mov ecx, num                 ; Address to store input
    mov edx, 1                   ; Number of bytes to read
    int 0x80                     ; Make syscall

    ; Convert input (ASCII) to integer
    movzx rax, byte [num]        ; Load input into rax (zero-extend)
    sub rax, '0'                 ; Convert ASCII to integer
    mov rdi, rax                 ; Move number to rdi for factorial calculation

    ; Call factorial subroutine
    call factorial

    ; Convert factorial result to string for printing
    mov rax, rdi                 ; Move factorial result to rax
    mov rsi, result              ; Address of result buffer
    call int_to_string           ; Convert integer to string

    ; Display result message
    mov eax, 4                   ; Syscall number for sys_write
    mov ebx, 1                   ; File descriptor (stdout)
    mov ecx, result_msg          ; Address of the result message
    mov edx, 10                  ; Length of the result message
    int 0x80                     ; Make syscall

    ; Display result
    mov eax, 4                   ; Syscall number for sys_write
    mov ebx, 1                   ; File descriptor (stdout)
    mov ecx, result              ; Address of the result
    mov edx, 20                  ; Max length of result
    int 0x80                     ; Make syscall

    ; Print newline
    mov eax, 4                   ; Syscall number for sys_write
    mov ebx, 1                   ; File descriptor (stdout)
    mov ecx, newline             ; Address of newline character
    mov edx, 1                   ; Length of newline
    int 0x80                     ; Make syscall

    ; Exit program
    mov eax, 1                   ; Syscall number for sys_exit
    xor ebx, ebx                 ; Exit code 0
    int 0x80                     ; Make syscall

; Factorial subroutine
; Input: Number in rdi
; Output: Result in rdi
factorial:
    push rbp                    ; Save base pointer
    mov rbp, rsp                ; Set up stack frame
    push rbx                    ; Preserve rbx (callee-saved register)

    ; Base case: if number <= 1, return 1
    cmp rdi, 1
    jle base_case

    ; Recursive case: factorial(n) = n * factorial(n-1)
    mov rbx, rdi                ; Save n in rbx
    sub rdi, 1                  ; Compute n-1
    call factorial              ; Recursive call
    imul rdi, rbx               ; Multiply n * factorial(n-1)
    jmp end_factorial

base_case:
    mov rdi, 1                  ; Return 1 for base case

end_factorial:
    pop rbx                     ; Restore rbx
    pop rbp                     ; Restore base pointer
    ret                         ; Return to caller

; Integer to string conversion subroutine
; Input: Integer in rax
; Output: String at address in rsi
int_to_string:
    mov rcx, 10                 ; Base 10
    xor rdx, rdx                ; Clear rdx (remainder)
    mov rbx, rsi                ; Save starting address of buffer
convert_digits:
    xor rdx, rdx                ; Clear rdx
    div rcx                     ; Divide rax by 10
    add dl, '0'                 ; Convert remainder to ASCII
    mov [rsi], dl               ; Store ASCII character in buffer
    inc rsi                     ; Move buffer pointer
    test rax, rax               ; Check if rax is 0
    jnz convert_digits          ; If not, continue dividing
    mov byte [rsi], 0           ; Null-terminate the string

    ; Reverse the digits
    dec rsi                     ; Adjust pointer to last digit
    mov rdi, rbx                ; Starting address of the buffer
reverse_string:
    cmp rdi, rsi                ; Check if pointers have crossed
    jge done_reverse            ; If yes, we're done
    mov al, [rdi]               ; Load current character
    mov bl, [rsi]               ; Load end character
    mov [rdi], bl               ; Swap characters
    mov [rsi], al               ; Swap characters
    inc rdi                     ; Move start pointer forward
    dec rsi                     ; Move end pointer backward
    jmp reverse_string
done_reverse:
    ret
