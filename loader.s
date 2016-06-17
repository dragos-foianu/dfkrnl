.set MAGIC, 0x1badb002      # multiboot sorcery
.set FLAGS, (1<<0 | 1<<1)
.set CHECKSUM, -(MAGIC + FLAGS)

.section .multiboot         # multiboot
    .long MAGIC
    .long FLAGS
    .long CHECKSUM

.section .text              # my code
.extern dfkrnlMain
.global entry

entry:
    mov $kernel_stack, %esp # setup a stack
    push %eax
    push %ebx
    call dfkrnlMain

_stop:
    cli                     # loop, just in case dfkrnlMain exits
    hlt                     # for some reason
    jmp _stop


.section .bss
.space 2*1024*1024          # 2 MB for stack to grow
kernel_stack:
