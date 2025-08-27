builtin.module {
  riscv_func.func @main(%0 : !riscv.reg, %1 : !riscv.reg, %2 : !riscv.reg) -> !riscv.reg {
    %3 = riscv.xor %0, %1 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %4 = riscv.srl %3, %1 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %5 = riscv.sll %3, %1 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %6 = riscv.rem %4, %5 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %7 = riscv.xor %0, %0 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %8 = riscv.divu %4, %1 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %9 = riscv.srl %8, %5 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %10 = riscv.mul %2, %9 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %11 = riscv.div %7, %10 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %12 = riscv.sltu %11, %6 : (!riscv.reg, !riscv.reg) -> !riscv.reg
    %13 = riscv.xori %12, 1 : (!riscv.reg) -> !riscv.reg
    riscv_func.return %13 : !riscv.reg
  }
}

