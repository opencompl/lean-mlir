builtin.module { 
^bb0(%0 : i64, %1 : i64):
  %2 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %3 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %4 = "riscv.divu"(%2, %3) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %5 = "riscv.sra"(%4, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i64)
  "llvm.return"(%6) : (i64) -> ()
 }
