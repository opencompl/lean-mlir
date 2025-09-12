builtin.module {
  riscv_func.func @main(%0 : !riscv.reg) -> !riscv.reg {
    riscv_func.return %0 : !riscv.reg
  }
}

