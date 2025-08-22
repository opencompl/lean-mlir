builtin.module { 
^bb0(%0 : i64):
  %1 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %2 = "riscv.and"(%1, %1) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %3 = "riscv.remu"(%2, %2) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%3) : (!riscv.reg) -> (i64)
  "llvm.return"(%4) : (i64) -> ()
 }
