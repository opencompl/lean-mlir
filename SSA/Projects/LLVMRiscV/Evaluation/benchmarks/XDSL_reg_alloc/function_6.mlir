builtin.module {
  riscv_func.func @main(%0 : !riscv.reg<t1>, %1 : !riscv.reg<t0>, %2 : !riscv.reg<t3>, %3 : !riscv.reg<t2>) -> !riscv.reg {
    %4 = riscv.sra %1, %1 : (!riscv.reg<t0>, !riscv.reg<t0>) -> !riscv.reg<t4>
    %5 = riscv.rem %0, %4 : (!riscv.reg<t1>, !riscv.reg<t4>) -> !riscv.reg<t1>
    %6 = riscv.sra %2, %2 : (!riscv.reg<t3>, !riscv.reg<t3>) -> !riscv.reg<t3>
    %7 = riscv.sub %6, %6 : (!riscv.reg<t3>, !riscv.reg<t3>) -> !riscv.reg<t3>
    %8 = riscv.srl %5, %7 : (!riscv.reg<t1>, !riscv.reg<t3>) -> !riscv.reg<t1>
    %9 = riscv.add %8, %1 : (!riscv.reg<t1>, !riscv.reg<t0>) -> !riscv.reg<t0>
    %10 = riscv.and %8, %9 : (!riscv.reg<t1>, !riscv.reg<t0>) -> !riscv.reg<t1>
    %11 = riscv.andi %3, 1 : (!riscv.reg<t2>) -> !riscv.reg<t2>
    %12 = riscv.sub %10, %11 : (!riscv.reg<t1>, !riscv.reg<t2>) -> !riscv.reg<t1>
    %13 = riscv.sltu %9, %12 : (!riscv.reg<t0>, !riscv.reg<t1>) -> !riscv.reg<t0>
    riscv_func.return %13 : !riscv.reg<t0>
  }
}

