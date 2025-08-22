builtin.module { 
^bb0(%0 : i64):
  %1 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %2 = "riscv.srl"(%1, %1) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %3 = "builtin.unrealized_conversion_cast"(%2) : (!riscv.reg) -> (i64)
  "llvm.return"(%3) : (i64) -> ()
 }
