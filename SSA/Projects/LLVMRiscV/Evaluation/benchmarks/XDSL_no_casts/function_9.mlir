builtin.module {
  riscv_func.func @main(%0 : !riscv.reg, %1 : !riscv.reg) -> !riscv.reg {
    %2 = riscv.srl %0, %0 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %3 = riscv.div %0, %2 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %4 = riscv.mul %3, %0 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %5 = riscv.sltu %2, %0 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %6 = riscv.slli %5, -1 : (!riscv.reg) -> !riscv.reg
    %7 = riscv.srai %6, -1 : (!riscv.reg) -> !riscv.reg
    %8 = riscv.or %4, %7 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %9 = riscv.andi %1, 1 : (!riscv.reg) -> !riscv.reg
    %10 = riscv.and %3, %9 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %11 = riscv.sub %0, %10 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %12 = riscv.slt %11, %8 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    riscv_func.return %12 : !riscv.reg
  }
}

