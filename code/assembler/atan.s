        .file   "atan.c"
        .intel_syntax noprefix
        .text
        .globl  calcAtan
        .type   calcAtan, @function
calcAtan:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 80
        movsd   QWORD PTR -40[rbp], xmm0
        movsd   QWORD PTR -48[rbp], xmm1
        movsd   xmm0, QWORD PTR -40[rbp]
        movsd   QWORD PTR -24[rbp], xmm0
        movsd   xmm0, QWORD PTR .LC0[rip]
        movsd   QWORD PTR -16[rbp], xmm0
.L2:
        movsd   xmm0, QWORD PTR -24[rbp]
        movsd   QWORD PTR -8[rbp], xmm0
        movsd   xmm0, QWORD PTR -16[rbp]
        movsd   xmm1, QWORD PTR .LC1[rip]
        subsd   xmm0, xmm1
        movsd   QWORD PTR -64[rbp], xmm0
        fld     QWORD PTR -64[rbp]
        lea     rsp, -16[rsp]
        fstp    TBYTE PTR [rsp]
        fld1
        fchs
        lea     rsp, -16[rsp]
        fstp    TBYTE PTR [rsp]
        call    powl@PLT
        add     rsp, 32
        fstp    TBYTE PTR -64[rbp]
        movsd   xmm0, QWORD PTR -16[rbp]
        addsd   xmm0, xmm0
        movsd   xmm1, QWORD PTR .LC1[rip]
        subsd   xmm0, xmm1
        movsd   QWORD PTR -72[rbp], xmm0
        fld     QWORD PTR -40[rbp]
        fld     QWORD PTR -72[rbp]
        lea     rsp, -16[rsp]
        fstp    TBYTE PTR [rsp]
        lea     rsp, -16[rsp]
        fstp    TBYTE PTR [rsp]
        call    powl@PLT
        add     rsp, 32
        fld     TBYTE PTR -64[rbp]
        fmulp   st(1), st
        movsd   xmm0, QWORD PTR -16[rbp]
        addsd   xmm0, xmm0
        movsd   xmm1, QWORD PTR .LC1[rip]
        subsd   xmm0, xmm1
        movsd   QWORD PTR -64[rbp], xmm0
        fld     QWORD PTR -64[rbp]
        fdivp   st(1), st
        fld     QWORD PTR -24[rbp]
        faddp   st(1), st
        fstp    QWORD PTR -24[rbp]
        movsd   xmm1, QWORD PTR -16[rbp]
        movsd   xmm0, QWORD PTR .LC1[rip]
        addsd   xmm0, xmm1
        movsd   QWORD PTR -16[rbp], xmm0
        movsd   xmm0, QWORD PTR -8[rbp]
        subsd   xmm0, QWORD PTR -24[rbp]
        movq    xmm1, QWORD PTR .LC3[rip]
        andpd   xmm0, xmm1
        comisd  xmm0, QWORD PTR -48[rbp]
        ja      .L2
        movsd   xmm0, QWORD PTR -24[rbp]
        movq    rax, xmm0
        movq    xmm0, rax
        leave
        ret
        .size   calcAtan, .-calcAtan
        .section        .rodata
.LC5:
        .string "%lf"
.LC6:
        .string "Incorrect input"
.LC8:
        .string "%lf\n"
        .text
        .globl  main
        .type   main, @function
main:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     rax, QWORD PTR fs:40
        mov     QWORD PTR -8[rbp], rax
        xor     eax, eax
        lea     rax, -24[rbp]
        mov     rsi, rax
        lea     rax, .LC5[rip]
        mov     rdi, rax
        mov     eax, 0
        call    __isoc99_scanf@PLT
        movsd   xmm0, QWORD PTR -24[rbp]
        movq    xmm1, QWORD PTR .LC3[rip]
        andpd   xmm0, xmm1
        movsd   xmm1, QWORD PTR .LC1[rip]
        comisd  xmm0, xmm1
        jbe     .L11
        lea     rax, .LC6[rip]
        mov     rdi, rax
        call    puts@PLT
        mov     eax, 0
        jmp     .L8
.L11:
        movsd   xmm0, QWORD PTR .LC7[rip]
        movsd   QWORD PTR -16[rbp], xmm0
        mov     rax, QWORD PTR -24[rbp]
        movsd   xmm0, QWORD PTR -16[rbp]
        movapd  xmm1, xmm0
        movq    xmm0, rax
        call    calcAtan
        movq    rax, xmm0
        movq    xmm0, rax
        lea     rax, .LC8[rip]
        mov     rdi, rax
        mov     eax, 1
        call    printf@PLT
        mov     eax, 0
.L8:
        mov     rdx, QWORD PTR -8[rbp]
        sub     rdx, QWORD PTR fs:40
        je      .L9
        call    __stack_chk_fail@PLT
.L9:
        leave
        ret
        .size   main, .-main
        .section        .rodata
        .align 8
.LC0:
        .long   0
        .long   1073741824
        .align 8
.LC1:
        .long   0
        .long   1072693248
        .align 16
.LC3:
        .long   -1
        .long   2147483647
        .long   0
        .long   0
        .align 8
.LC7:
        .long   -755914244
        .long   1061184077
        .ident  "GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
        .section        .note.GNU-stack,"",@progbits
