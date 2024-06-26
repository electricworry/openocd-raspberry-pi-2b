.section ".text.boot"

.global _start

_start:
    @ Wait for JTAG
    wfe
    b _start

    @ Halt three of the four cores
    mrc p15, #0, r1, c0, c0, #5
    and r1, r1, #3
    cmp r1, #0
    bne halt

    mov sp, #0x8000 @ Set stack to 0x8000. The kernel is loaded at 0x8000 so there is no overlap

    # Load __bss_start and __bss_end 
    ldr r4, =__bss_start
    ldr r9, =__bss_end
    mov r5, #0
    mov r6, #0
    mov r7, #0
    mov r8, #0
    b       2f @ Branch to '2' forwards

1:
    stmia r4!, {r5-r8} @ Write 16-bytes and increment

2:
    cmp r4, r9
    blo 1b @ Branch to '1' backwards if r4 < r9

halt:   # Spin forever (halt)
    wfe
    b halt