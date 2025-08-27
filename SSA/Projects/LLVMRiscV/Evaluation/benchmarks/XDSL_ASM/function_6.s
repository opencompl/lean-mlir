.text
main:
    sra t4, t0, t0
    rem t1, t1, t4
    sra t3, t3, t3
    sub t3, t3, t3
    srl t1, t1, t3
    add t0, t1, t0
    and t1, t1, t0
    andi t2, t2, 1
    sub t1, t1, t2
    sltu t0, t0, t1
    ret
