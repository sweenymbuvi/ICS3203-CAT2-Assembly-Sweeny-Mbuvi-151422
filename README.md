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
     ld task1.o -o task1
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

# Task 2: Reverse Array Program

## Overview

This program reverses an array of 5 user-inputted numbers. It takes the numbers as input, reverses the array in place using assembly language, and then prints the reversed array.

## Instructions for Compiling and Running

### Steps to Compile and Run:

1. **Assemble the code**:
   - Open a terminal and navigate to the directory containing `task2.asm`.
   - Assemble the code using NASM:
     ```bash
     nasm -f elf32 -o task2.o task2.asm
     ```
   
2. **Link the object file**:
   - Link the object file using the `ld` linker:
     ```bash
     ld task2.o -o task2
     ```

3. **Run the program**:
   - Run the program:
     ```bash
     ./task2
     ```

The program will prompt you to enter 5 numbers, reverse the input array, and display the reversed array.

### Insights and Challenges

- **Challenges with array management**: Handling the array in assembly required managing pointers manually. Using two pointers (`esi` and `edi`) allowed for efficient in-place reversal of the array.
  
- **Character handling**: The program treats input as characters (numbers are entered as ASCII values), which could be confusing if the input is not formatted correctly.

- **System calls**: The program relies on Linux system calls (`sys_write`, `sys_read`, `sys_exit`) to handle input/output, which required a good understanding of low-level assembly programming.

- **Pointer management**: The use of `esi` (source index) and `edi` (destination index) registers for array traversal and reversal helped streamline the process, but also introduced complexities in managing memory directly at the assembly level.

## Task 3: Factorial Calculation Program

### Overview

This program calculates the factorial of a user-inputted number. The program performs the following steps:

1. Displays a prompt asking the user to enter a number.
2. Reads the user input and converts it from ASCII to an integer.
3. Calculates the factorial of the number using recursion.
4. Converts the result from integer to string.
5. Displays the result.

The program relies on Linux system calls to handle input/output and demonstrates fundamental concepts like recursion, integer-to-string conversion, and system call usage in assembly.

### Instructions for Compiling and Running

1. **Assemble the code**:
   - Open a terminal and navigate to the directory containing `task3.asm`.
   - Assemble the code using NASM:
     ```bash
     nasm -f elf32 -o task3.o task3.asm
     ```

2. **Link the object file**:
   - Link the object file using the `ld` linker:
     ```bash
     ld task3.o -o task3
     ```

3. **Run the program**:
   - Run the program:
     ```bash
     ./task3
     ```

   The program will prompt you to enter a number, calculate the factorial of the number, and display the result.

### Insights and Challenges

- **Recursion**: The factorial calculation uses recursion, which requires careful stack management to avoid overflow or incorrect results. Each recursive call decreases the number until the base case is reached.
  
- **Integer to String Conversion**: Converting an integer to a string is handled manually in assembly, which requires dividing the number by 10 and extracting the remainder as an ASCII character for each digit.

- **System Calls**: The program demonstrates the use of Linux system calls for interacting with input/output. This required a good understanding of how to interface with the system at a low level.

## Task 4: Water Level Sensor and Motor Control Program

### Overview

This assembly program simulates a water level sensor and controls a motor and alarm based on the sensor's value. The program is designed to:

1. Prompt the user to enter a sensor value (simulating a water level).
2. Convert the input from ASCII to an integer.
3. Control a motor and alarm based on the water level:
   - **Low water level (value < 2)**: Turns the motor off and displays a "low" water level message.
   - **Moderate water level (value between 2 and 5)**: Turns the motor off and displays a "moderate" water level message.
   - **High water level (value > 5)**: Turns the motor off and triggers the alarm with a "high" water level message.
4. Handles invalid inputs (non-numeric or out-of-range values).

The program uses Linux system calls for input/output operations and demonstrates basic concepts like memory management, integer conversion, and conditional branching in assembly.

---

### Instructions for Compiling and Running

1. **Assemble the code**:
   - Open a terminal and navigate to the directory containing `task4.asm`.
   - Assemble the code using NASM:
     ```bash
     nasm -f elf32 -o task4.o task4.asm
     ```

2. **Link the object file**:
   - Link the object file using the `ld` linker:
     ```bash
     ld task4.o -o task4
     ```

3. **Run the program**:
   - Run the program:
     ```bash
     ./task4
     ```
### Insights and Challenges

### Insights
1. **System Call Usage**: The program demonstrates low-level interaction with the OS using Linux system calls for input and output.
2. **Manual Input Conversion**: ASCII to integer conversion is handled manually, showcasing direct data manipulation in assembly.
3. **Conditional Logic**: The program uses conditional jumps to handle different water level thresholds, emphasizing control flow in assembly.

### Challenges
1. **Limited Input Handling**: The program only accepts single-digit inputs (0-9), limiting its functionality.
2. **Memory Management**: Manual handling of memory increases the risk of errors like improper access.
3. **Debugging Complexity**: Debugging assembly programs is challenging due to the low-level nature of memory and system call usage.
