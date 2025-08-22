builtin.module { 
^bb0(%0 : i64, %1 : i1):
  %2 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %3 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%0) : (i1) -> (!riscv.reg)
  %5 = "riscv.slli"(%4){shamt = -1 : i6 } : (!riscv.reg) -> (!riscv.reg)
  %6 = "riscv.srai"(%5){shamt = -1 : i6 } : (!riscv.reg) -> (!riscv.reg)
  %7 = "riscv.and"(%2, %6) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %8 = "riscv.li"() {immediate = -1 : i32 } : () -> (!riscv.reg)
  %9 = "riscv.xor"(%8, %6) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %10 = "riscv.and"(%9, %3) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %11 = "riscv.or"(%7, %10) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %12 = "builtin.unrealized_conversion_cast"(%11) : (!riscv.reg) -> (i64)
  "llvm.return"(%12) : (i64) -> ()
 }
