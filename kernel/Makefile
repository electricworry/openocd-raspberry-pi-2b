
.PHONY: all

all:
	~/x-tools/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-gcc -mcpu=cortex-a7 -fpic -ffreestanding -c boot.S -o boot.o
	~/x-tools/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-gcc -T linker.ld -o myos.elf -ffreestanding -O2 -nostdlib boot.o
	~/x-tools/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-objcopy myos.elf -O binary kernel7.img
	