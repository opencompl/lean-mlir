builtin.module {
  riscv_func.func @main(%0 : !riscv.reg, %1 : !riscv.reg, %2 : !riscv.reg, %3 : !riscv.reg) -> !riscv.reg {
    %4 = riscv.sra %1, %1 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %5 = riscv.rem %0, %4 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %6 = riscv.sra %2, %2 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %7 = riscv.sub %6, %6 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %8 = riscv.srl %5, %7 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %9 = riscv.add %8, %1 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %10 = riscv.and %8, %9 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %11 = riscv.andi %3, 1 : (!riscv.reg) -> !riscv.reg
    %12 = riscv.sub %10, %11 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %13 = riscv.sltu %9, %12 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    riscv_func.return %13 : !riscv.reg
  }
}

