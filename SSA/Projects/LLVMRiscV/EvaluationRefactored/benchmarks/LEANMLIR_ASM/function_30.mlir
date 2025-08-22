builtin.module { 
^bb0(%0 : i64, %1 : i64):
  %2 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %3 = "riscv.sltu"(%2, %2) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %4 = "riscv.xori"(%3){immediate = 1 : si12 } : (!riscv.reg) -> (!riscv.reg)
  %5 = "builtin.unrealized_conversion_cast"(%4) : (!riscv.reg) -> (i1)
  %6 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %7 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %8 = "builtin.unrealized_conversion_cast"(%5) : (i1) -> (!riscv.reg)
  %9 = "riscv.slli"(%8){shamt = -1 : i6 } : (!riscv.reg) -> (!riscv.reg)
  %10 = "riscv.srai"(%9){shamt = -1 : i6 } : (!riscv.reg) -> (!riscv.reg)
  %11 = "riscv.and"(%6, %10) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %12 = "riscv.li"() {immediate = -1 : i32 } : () -> (!riscv.reg)
  %13 = "riscv.xor"(%12, %10) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %14 = "riscv.and"(%13, %7) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %15 = "riscv.or"(%11, %14) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %16 = "builtin.unrealized_conversion_cast"(%15) : (!riscv.reg) -> (i64)
  "llvm.return"(%16) : (i64) -> ()
 }
