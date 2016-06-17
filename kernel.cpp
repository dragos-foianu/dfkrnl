
/* Worst printf in the multiverse */
void printf(const char * str)
{
    /* Video memory pointer */
    unsigned short * vMem = (unsigned short *) 0xb8000;

    /* Video memory:
        0xFF00 <- 1st byte, color information
        0x00FF <- 2nd byte, character code

        vMem is already populated with default color information
        (white text on black background). Make sure we are not
        overwriting the first byte.
    */
    for (; *str != '\0'; str++) {
        *(vMem) = (*vMem & 0xFF00) | *(str);
        vMem++;
    }
}

/* Entry */
extern "C" void dfkrnlMain(void * multiboot, unsigned int magic)
{
    printf("Hello, World!");

    while (1);
}
