.set FALIGN, 1<<0                   # modules loaded along with the OS will be aligned on page (4K) boundaries
.set FMEM,   1<<1                   # information on available memory will be provided
.set FLAGS,      (FALIGN | FMEM  )  # flags
.set MAGIC,      0x1badb002         # multiboot sorcery
.set CHECKSUM,   -(MAGIC + FLAGS)   # checksum

.section .multiboot                 # multiboot
.align 4
    .long MAGIC
    .long FLAGS
    .long CHECKSUM

.section .text                      # my code
.extern kmain
.global entry

entry:
    mov $kernel_stack, %esp         # setup a stack to prepare for C++ code
    call kmain

    # kmain should not return. Hang the computer.
    cli                             # disable interrupts
    hlt                             # halt until next interrupt
_stop:
    jmp _stop

.section .bss
.space 2*1024*1024                  # 2 MB for stack to grow
kernel_stack:
