builtin.module { 
^bb0(%0 : i64):
  %1 = "llvm.srem"(%0, %0) : (i64, i64) -> (i64)
  %2 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %3 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %4 = "riscv.or"(%2, %3) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %5 = "builtin.unrealized_conversion_cast"(%4) : (!riscv.reg) -> (i64)
  "llvm.return"(%5) : (i64) -> ()
 }
