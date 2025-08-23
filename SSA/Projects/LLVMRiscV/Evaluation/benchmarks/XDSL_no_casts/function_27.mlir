builtin.module {
  riscv_func.func @main(%0 : !riscv.reg) -> !riscv.reg {
    %1 = riscv.slt %0, %0 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    riscv_func.return %1 : !riscv.reg
  }
}

