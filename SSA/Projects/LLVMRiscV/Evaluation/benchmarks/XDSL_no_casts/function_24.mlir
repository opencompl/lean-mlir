builtin.module {
  riscv_func.func @main(%0 : !riscv.reg) -> !riscv.reg {
    %1 = riscv.div %0, %0 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %2 = riscv.or %1, %0 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    riscv_func.return %2 : !riscv.reg
  }
}

