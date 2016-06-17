
ENTRY(entry)
OUTPUT_FORMAT(elf32-i386)
OUTPUT_ARCH(i386:i386)

SECTIONS
{
    . = 0x0100000;

    /* multiboot, all text sections and rodata */
    .text :
    {
        *(.multiboot)
        *(.text*)
        *(.rodata)
    }

    /* global object constructors and all data sections */
    .data :
    {
        start_ctors = .;
        KEEP(*(.init_array))
        KEEP(*(SORT_BY_INIT_PRIORITY(.init_array.*)))
        end_ctors = .;

        *(.data)
    }

    /* stack segment */
    .bss :
    {
        *(.bss)
    }

    /* it's ok to remove these symbols */
    /DISCARD/ :
    {
        *(.fini_array*)
        *(.comment)
    }
}
