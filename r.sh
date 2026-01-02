# Author: Elliot Kim
# Program Name: IEEE
# Purpose: Convert normal numbers to IEEE form

rm *.o
rm *.out

echo "This program converts any number to IEEE form."

echo "Assemble the module IEEE.asm"
nasm -f elf64 -l IEEE.lis -o file1.o IEEE.asm

echo "Compile the C file main.c"
gcc -m64 -Wall -no-pie -o main.o -std=c2x -c main.c

echo "Link the two object files already created"
gcc -m64 -no-pie -o output.out main.o file1.o -std=c2x -Wall -z noexecstack -lm

echo "Run the program IEEE Converter"
chmod +x output.out
./output.out

echo "The bash file will now terminate."
