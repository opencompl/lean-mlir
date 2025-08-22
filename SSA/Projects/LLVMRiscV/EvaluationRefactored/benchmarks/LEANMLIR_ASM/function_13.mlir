builtin.module { 
^bb0(%0 : i64):
  %1 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %2 = "riscv.divu"(%1, %1) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %3 = "builtin.unrealized_conversion_cast"(%2) : (!riscv.reg) -> (i64)
  %4 = "llvm.srem"(%0, %3) : (i64, i64) -> (i64)
  "llvm.return"(%4) : (i64) -> ()
 }
