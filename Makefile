CPP_FLAGS=-ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti
ASM_FLAGS=
LD_FLAGS=-ffreestanding -O2 -nostdlib -lgcc

TOOLCHAIN=../cross
CPP=$(TOOLCHAIN)/bin/i686-elf-g++
ASM=$(TOOLCHAIN)/bin/i686-elf-as
LNK=$(TOOLCHAIN)/bin/i686-elf-g++

files = loader.o kernel.o

%.o: %.cpp
	$(CPP) $(CPP_FLAGS) -o $@ -c $<

%.o: %.s
	$(ASM) $(ASM_FLAGS) -o $@ $<

dfkrnl.bin: linker.ld $(files)
	$(LNK) $(LD_FLAGS) -T $< -o $@ $(files)

build: dfkrnl.bin

install: dfkrnl.bin
	sudo cp $< /boot/
	sudo bash -c 'cat grubtemplate >> /boot/grub/grub.cfg'

clean:
	rm -rf *.o dfkrnl.bin
