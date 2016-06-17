CPP_FLAGS=-m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore
ASM_FLAGS=--32
LD_FLAGS=-melf_i386

CPP=g++
ASM=as
LNK=ld

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
