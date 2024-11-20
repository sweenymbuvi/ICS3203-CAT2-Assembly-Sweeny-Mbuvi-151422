# ICS3203-CAT2-Assembly-Sweeny-Mbuvi-151422

## Task 1: Classifying Numbers as Positive, Negative, or Zero

### Overview
This program is an assembly implementation that prompts the user to input a number, processes the input, and classifies it as either positive, negative, or zero. The program demonstrates basic integer operations, string handling, and system calls in Linux assembly using NASM.

---

### Instructions for Compiling and Running

1. **Prerequisites**:
   - A Linux environment.
   - NASM assembler and the `ld` linker installed.

2. **Steps to Compile and Run**:
   - Open a terminal and navigate to the directory containing `task1.asm`.
   - Assemble the code using NASM:
     ```bash
     nasm -f elf32 -o task1.o task1.asm
     ```
   - Link the object file using the `ld` linker:
     ```bash
     ld -m elf_i386 -s -o task1 task1.o
     ```
   - Run the program:
     ```bash
     ./task1
     ```
   - Enter an integer when prompted. The program will display whether the number is `POSITIVE`, `NEGATIVE`, or `ZERO`.

---

### Insights and Challenges

#### Insights:
- The program utilizes system calls (`sys_write` and `sys_read`) to interact with the user via standard input and output. These syscalls are essential for basic I/O operations in Linux assembly.
- Logical flow control using conditional and unconditional jump instructions (`je`, `jne`, and `jmp`) ensures efficient classification of the input.
- The ASCII-to-integer conversion highlights the importance of understanding character encoding when handling user input.

#### Challenges Encountered:
1. **Input Processing**:
   - Initially, there were issues converting the input string to an integer. The ASCII-to-integer conversion logic was debugged and corrected by subtracting the ASCII value of `'0'` from each digit.

2. **Handling Edge Cases**:
   - Handling zero as a special case required additional checks to avoid incorrectly classifying it as positive or negative.

