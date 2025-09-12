builtin.module {
  riscv_func.func @main(%0 : !riscv.reg<t0>, %1 : !riscv.reg<t5>, %2 : !riscv.reg<t2>) -> !riscv.reg {
    %3 = riscv.xor %0, %1 : (!riscv.reg<t0>, !riscv.reg<t5>) -> !riscv.reg<t4>
    %4 = riscv.srl %3, %1 : (!riscv.reg<t4>, !riscv.reg<t5>) -> !riscv.reg<t3>
    %5 = riscv.sll %3, %1 : (!riscv.reg<t4>, !riscv.reg<t5>) -> !riscv.reg<t4>
    %6 = riscv.rem %4, %5 : (!riscv.reg<t3>, !riscv.reg<t4>) -> !riscv.reg<t1>
    %7 = riscv.xor %0, %0 : (!riscv.reg<t0>, !riscv.reg<t0>) -> !riscv.reg<t0>
    %8 = riscv.divu %4, %1 : (!riscv.reg<t3>, !riscv.reg<t5>) -> !riscv.reg<t3>
    %9 = riscv.srl %8, %5 : (!riscv.reg<t3>, !riscv.reg<t4>) -> !riscv.reg<t3>
    %10 = riscv.mul %2, %9 : (!riscv.reg<t2>, !riscv.reg<t3>) -> !riscv.reg<t2>
    %11 = riscv.div %7, %10 : (!riscv.reg<t0>, !riscv.reg<t2>) -> !riscv.reg<t0>
    %12 = riscv.sltu %11, %6 : (!riscv.reg<t0>, !riscv.reg<t1>) -> !riscv.reg<t0>
    %13 = riscv.xori %12, 1 : (!riscv.reg<t0>) -> !riscv.reg<t0>
    riscv_func.return %13 : !riscv.reg<t0>
  }
}

