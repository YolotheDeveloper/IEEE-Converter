
// ****************************************************************************************************************************
// Program name: "Int Arrays". This program shows that it can take unlimited amount of numbers from the user, put them into   *
// 2 different arrays, and output a magnitude and mean.  Copyright (C) 2025  Elliot Kim                                       *
// This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
// version 3 as published by the Free Software Foundation.                                                                    *
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
// A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
// ****************************************************************************************************************************


// Author information
//  Author name: Elliot Kim
//  Author email: Yolo@csu.fullerton.edu or elliotk2004@gmail.com or both

// Program information
//  Program name: Arrays
//  Programming languages X86 with 2 module in C language
//  Date development of version 1.5 began 2025-Sept-10
//  Date development of version 1.5 completed 2025-Sep-21

// Purpose
//  This program will take take as many numbers as the user wants, onto 2 different arrays, before calculating both magnitude and mean.

// Project information
//  Files: main.c, manager.asm, magnitude.asm, input_array.asm, display_array.c, append.asm, grps.inc, r.sh, mean.asm
//  Status: The program has been tested extensively with no detectable errors.

// Translator information
//  Gnu compiler: gcc -m64 -Wall -no-pie -o display_array.o -std=c2x -c display_array.c
//  Gnu linker:   gcc -m64 -no-pie -o output.out main.o display_array.o file1.o file2.o file3.o file4.o file5.o -std=c2x -Wall -z noexecstack -lm

// Execution: ./output.out

// References and credits
//  No references: this module is standard C


// ===== Begin code area



#include <stdio.h>

extern double manager();

int main(void)
{printf("Welcome to the IEEE converter\n");
 printf("This software is maintained by Elliot Kim.\n");
 printf("For assistance contact the developer at Yolo@csu.fullerton.edu\n");
//  float value = 0;
 double input = 0;
 input = manager();
 unsigned long long bits = *(unsigned long long*)&input;
 printf("\nRepeat IEEE print: 0x%016llX", bits);
 printf("\nThe driver has received this number %lf and will keep it for future use. Have a great day.\n", input);
 printf("A zero will be sent to the operating system.\n");
 return 0;
}
