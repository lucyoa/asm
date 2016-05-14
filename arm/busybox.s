.data

busy:
    .ascii  "/bin/busybox\0"
sh:
    .ascii  "sh\0"

.text
.globl _start

_start:
    ldr     r0, =busy
    mov     r1, r0
    eor     r2, r2
    push    {r2}
    ldr     r1, =sh
    push    {r1}
    mov     r1, sp
    mov     r7, $11
    swi     $0

    mov     r0, $0
    mov     r7, $1
    swi     $0
