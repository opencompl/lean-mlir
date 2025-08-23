builtin.module {
  riscv_func.func @main(%0 : !riscv.reg, %1 : !riscv.reg) -> !riscv.reg {
    %2 = riscv.divu %0, %1 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %3 = riscv.sra %2, %2 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    riscv_func.return %3 : !riscv.reg
  }
}

