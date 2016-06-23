/* start executing at symbol "entry" (in loader.s) */
ENTRY(entry)

SECTIONS
{
    /* Like all kernels, begin at 1MiB */
    . = 1M;

    /* multiboot, text */
    .text ALIGN(4K) :
    {
        *(.multiboot)
        *(.text)
    }

    /* read-only data */
    .rodata ALIGN(4K) :
    {
        *(.rodata)
    }

    /* read-write initialized data */
    .data ALIGN(4K) :
    {
        /* global object constructors */
        start_ctors = .;
        KEEP(*(.init_array))
        KEEP(*(SORT_BY_INIT_PRIORITY(.init_array.*)))
        end_ctors = .;

        *(.data)
    }

    /* read-write unitialized data and stack */
    .bss ALIGN(4K) :
    {
        *(COMMON)
        *(.bss)
    }

    /* it's ok to remove these symbols */
    /DISCARD/ :
    {
        *(.fini_array*)
        *(.comment)
    }
}
