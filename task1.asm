section .data
    prompt db "Enter a number: ", 0           ; Message to prompt user for input
    positive_msg db "POSITIVE", 10, 0         ; Message for positive numbers
    negative_msg db "NEGATIVE", 10, 0         ; Message for negative numbers
    zero_msg db "ZERO", 10, 0                 ; Message for zero
    buffer db 0                               ; Buffer for temporary storage (not used in this code)

section .bss
    input resb 4                              ; Reserve 4 bytes for user input

section .text
    global _start

_start:
    ; Display the prompt to the user
    mov eax, 4                                ; syscall: sys_write
    mov ebx, 1                                ; file descriptor: stdout
    mov ecx, prompt                           ; Address of the prompt message
    mov edx, 15                               ; Length of the prompt message
    int 0x80                                  ; Make the system call

    ; Read user input from the keyboard
    mov eax, 3                                ; syscall: sys_read
    mov ebx, 0                                ; file descriptor: stdin
    mov ecx, input                            ; Buffer to store user input
    mov edx, 4                                ; Maximum number of bytes to read
    int 0x80                                  ; Make the system call

    ; Convert the input string to an integer
    mov esi, input                            ; Point to the input buffer
    xor eax, eax                              ; Clear eax to accumulate the integer value
    xor ebx, ebx                              ; Clear ebx to track the sign (0 = positive, 1 = negative)

    ; Check if the number is negative
    cmp byte [esi], '-'                       ; Compare the first character with '-'
    jne read_digits                           ; If not negative, jump to read digits
    inc esi                                   ; Skip the '-' character
    mov ebx, 1                                ; Set sign flag to indicate negative number

read_digits:
    xor ecx, ecx                              ; Clear ecx to store the number
next_digit:
    movzx edx, byte [esi]                     ; Load the next character as an integer
    cmp edx, 10                               ; Check for newline (end of input)
    je classify_number                        ; If newline, jump to classify the number
    sub edx, '0'                              ; Convert ASCII digit to integer
    imul ecx, ecx, 10                         ; Multiply the current value by 10
    add ecx, edx                              ; Add the new digit to the value
    inc esi                                   ; Move to the next character
    jmp next_digit                            ; Loop to process the next digit

classify_number:
    ; Determine if the number is negative, zero, or positive
    cmp ebx, 1                                ; Check the sign flag
    je is_negative                            ; If negative, jump to handle negative case

    cmp ecx, 0                                ; Check if the value is zero
    je is_zero                                ; If zero, jump to handle zero case

    ; If none of the above, the number is positive
    jmp is_positive

is_positive:
    ; Output the "POSITIVE" message
    mov eax, 4                                ; syscall: sys_write
    mov ebx, 1                                ; file descriptor: stdout
    mov ecx, positive_msg                     ; Address of the positive message
    mov edx, 9                                ; Length of the message
    int 0x80                                  ; Make the system call
    jmp exit                                  ; Exit the program

is_negative:
    ; Output the "NEGATIVE" message
    mov eax, 4                                ; syscall: sys_write
    mov ebx, 1                                ; file descriptor: stdout
    mov ecx, negative_msg                     ; Address of the negative message
    mov edx, 9                                ; Length of the message
    int 0x80                                  ; Make the system call
    jmp exit                                  ; Exit the program

is_zero:
    ; Output the "ZERO" message
    mov eax, 4                                ; syscall: sys_write
    mov ebx, 1                                ; file descriptor: stdout
    mov ecx, zero_msg                         ; Address of the zero message
    mov edx, 5                                ; Length of the message
    int 0x80                                  ; Make the system call

exit:
    ; Exit the program
    mov eax, 1                                ; syscall: sys_exit
    xor ebx, ebx                              ; Exit code 0
    int 0x80                                  ; Make the system call
