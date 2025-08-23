builtin.module {
  riscv_func.func @main(%0 : !riscv.reg<t0>, %1 : !riscv.reg<t1>) -> !riscv.reg {
    %2 = riscv.divu %0, %1 : (!riscv.reg<t0>, !riscv.reg<t1>) -> !riscv.reg<t0>
    riscv_func.return %2 : !riscv.reg<t0>
  }
}

