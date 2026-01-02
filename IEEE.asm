
; ****************************************************************************************************************************
; Program name: "Int Arrays". This program shows that it can take unlimited amount of numbers from the user, put them into   *
; 2 different arrays, and output a magnitude and mean.  Copyright (C) 2025  Elliot Kim                                       *
; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
; version 3 as published by the Free Software Foundation.                                                                    *
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
; A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
; ****************************************************************************************************************************


; Author information
;  Author name: Elliot Kim
;  Author email: Yolo@csu.fullerton.edu or elliotk2004@gmail.com or both

; Program information
;  Program name: Arrays
;  Programming languages X86 with 2 module in C language
;  Date development of version 1.5 began 2025-Sept-10
;  Date development of version 1.5 completed 2025-Sep-21

; Purpose
;  This program will take take as many numbers as the user wants, onto 2 different arrays, before calculating both magnitude and mean.

; Project information
;  Files: main.c, manager.asm, magnitude.asm, input_array.asm, display_array.c, append.asm, grps.inc, r.sh, mean.asm
;  Status: The program has been tested extensively with no detectable errors.

; Translator information
;  Gnu compiler: gcc -m64 -Wall -no-pie -o display_array.o -std=c2x -c display_array.c
;  Gnu linker:   gcc -m64 -no-pie -o output.out main.o display_array.o file1.o file2.o file3.o file4.o file5.o -std=c2x -Wall -z noexecstack -lm

; Execution: ./output.out

; References and credits
;  No references: this module is standard C++


; ===== Begin code area


global manager


extern printf
extern scanf
extern fgets
extern atoi
extern stdin
extern cos
extern strlen


segment .data
  message0 db "Enter your number.", 10, 0
  message1 db "Here is your IEEE number: %lf", 10, 0



  message8 db "Would you like to convert more numbers? (y != 0/n = 0)", 10, 0
  message9 db "invalid.", 10, 0

  testing1 db "%d", 0
  testing2 db "%lf", 0
  fmt_hex db "IEEE bits: 0x%016llX",10,0
  yes db "y"
  nay db "n"

  fmt_sign     db "Sign bit: %llu",10,0
  fmt_exp      db "Exponent (biased): %llu",10,0
  fmt_exp_u    db "Exponent (unbiased): %lld",10,0
  fmt_mant     db "Mantissa: %013llX",10,0

  zero dq 0
  increment dq 1

segment .bss
  number resq 1
  convert resq 1
  increment0 resq 1

  yon resq 1

segment .text
manager:
    push       rbp                                              ;Save a copy of the stack base pointer
    mov        rbp, rsp                                         ;We do this in order to be 100% compatible with C and C++.
    push       rbx                                              ;Back up rbx
    push       rcx                                              ;Back up rcx
    push       rdx                                              ;Back up rdx
    push       rsi                                              ;Back up rsi
    push       rdi                                              ;Back up rdi
    push       r8                                               ;Back up r8
    push       r9                                               ;Back up r9
    push       r10                                              ;Back up r10
    push       r11                                              ;Back up r11
    push       r12                                              ;Back up r12
    push       r13                                              ;Back up r13
    push       r14                                              ;Back up r14
    push       r15                                              ;Back up r15
    pushf
    jmp starting


starting:
    mov rax, 0
    mov rdi, message0
    call printf

    mov rax, 0
    lea rdi, [rel testing2]
    lea rsi, [rel number]
    call scanf

    mov rax, [number]
    mov [convert], rax

    mov rax, [convert]
    shr rax, 63
    mov rax, [convert]
    mov rsi, rax           ;load IEEE
    lea rdi, [rel fmt_hex] ;load format
    xor rax, rax
    call printf            ;print IEEE value

    mov rax, [convert]
    shr rax, 63
    mov rsi, rax            ;load sign bit value
    lea rdi, [rel fmt_sign] ;load format
    xor rax, rax
    call printf             ;print the sign bit

    mov rax, [convert]
    shr rax, 52
    and rax, 0x7FF
    mov rsi, rax            ;load biased exp value
    lea rdi, [rel fmt_exp]  ;load format
    xor rax, rax
    call printf             ;print biased exp

    mov rax, [convert]
    shr rax, 52
    and rax, 0x7FF
    sub rax, 1023           ;convert to unbiased exp value
    mov rsi, rax            ;load unbiased exp
    lea rdi, [rel fmt_exp_u];load format
    xor rax, rax
    call printf             ;print unbiased exp

    mov rax, [convert]
    shl rax, 12
    and rax, 0xFFFFFFFFFFFFF;filter
    mov rsi, rax
    lea rdi, [rel fmt_mant] ;load format
    xor rax, rax
    call printf             ;print mantissa

    mov rax, 0
    mov rdi, message8
    call printf
    jmp looper

  looper:
    mov rax, 0
    lea rdi, [rel testing1]
    lea rsi, [rel yon]
    call scanf

    cmp qword [yon], 0
    jne starting

    jmp done


  done:
    ; mov rax, [convert]
    movsd xmm0, [convert]

    popf                                                        ;Restore rflags
    pop        r15                                              ;Restore r15
    pop        r14                                              ;Restore r14
    pop        r13                                              ;Restore r13
    pop        r12                                              ;Restore r12
    pop        r11                                              ;Restore r11
    pop        r10                                              ;Restore r10
    pop        r9                                               ;Restore r9
    pop        r8                                               ;Restore r8
    pop        rdi                                              ;Restore rdi
    pop        rsi                                              ;Restore rsi
    pop        rdx                                              ;Restore rdx
    pop        rcx                                              ;Restore rcx
    pop        rbx                                              ;Restore rbx
    pop        rbp                                              ;Restore rbp
    ret
