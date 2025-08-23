builtin.module {
  riscv_func.func @main(%0 : !riscv.reg<t0>) -> !riscv.reg {
    %1 = riscv.srl %0, %0 : (!riscv.reg<t0>, !riscv.reg<t0>) -> !riscv.reg<t0>
    riscv_func.return %1 : !riscv.reg<t0>
  }
}

