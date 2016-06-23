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

iso: dfkrnl.bin
	mkdir -p isotmp/boot/grub/
	cp dfkrnl.bin isotmp/boot/
	cp grub.cfg isotmp/boot/grub/grub.cfg
	grub-mkrescue -o dfkrnl.iso isotmp
	rm -rf isotmp

clean:
	rm -rf *.o dfkrnl.bin dfkrnl.iso
