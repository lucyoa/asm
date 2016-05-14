.data

sh:
    .ascii  "/bin/sh\0"

.text
.globl _start

_start:
    ldr     r0, =sh
    mov     r1, r0
    eor     r2, r2
    push    {r2}
    mov     r1, sp
    mov     r7, $11
    swi     $0

    mov     r0, $0
    mov     r7, $1
    swi     $0
