builtin.module {
  riscv_func.func @main(%0 : !riscv.reg, %1 : !riscv.reg, %2 : !riscv.reg) -> !riscv.reg {
    %3 = riscv.add %0, %0 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %4 = riscv.xor %2, %2 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %5 = riscv.slli %1, -1 : (!riscv.reg) -> !riscv.reg
    %6 = riscv.srai %5, -1 : (!riscv.reg) -> !riscv.reg
    %7 = riscv.and %0, %6 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %8 = riscv.li -1 : !riscv.reg
    %9 = riscv.xor %8, %6 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %10 = riscv.and %9, %4 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %11 = riscv.or %7, %10 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %12 = riscv.srl %11, %4 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %13 = riscv.sltu %3, %12 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %14 = riscv.slli %13, -1 : (!riscv.reg) -> !riscv.reg
    %15 = riscv.srai %14, -1 : (!riscv.reg) -> !riscv.reg
    %16 = riscv.mul %3, %12 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %17 = riscv.sll %15, %16 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %18 = riscv.slt %17, %16 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    riscv_func.return %18 : !riscv.reg
  }
}

