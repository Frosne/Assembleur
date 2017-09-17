build: 
	nasm -f elf scas_example.asm 2>&1
	ld -m elf_i386 -s -o demo scas_example.o 2>&1
	./demo
