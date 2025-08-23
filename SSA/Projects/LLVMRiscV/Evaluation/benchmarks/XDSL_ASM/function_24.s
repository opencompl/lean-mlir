builtin.module {
  riscv_func.func @main(%0 : !riscv.reg<t1>) -> !riscv.reg {
    %1 = riscv.div %0, %0 : (!riscv.reg<t1>, !riscv.reg<t1>) -> !riscv.reg<t0>
    %2 = riscv.or %1, %0 : (!riscv.reg<t0>, !riscv.reg<t1>) -> !riscv.reg<t0>
    riscv_func.return %2 : !riscv.reg<t0>
  }
}

