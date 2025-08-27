.text
main:
    xor t4, t0, t5
    srl t3, t4, t5
    sll t4, t4, t5
    rem t1, t3, t4
    xor t0, t0, t0
    divu t3, t3, t5
    srl t3, t3, t4
    mul t2, t2, t3
    div t0, t0, t2
    sltu t0, t0, t1
    xori t0, t0, 1
    ret
