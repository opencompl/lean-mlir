builtin.module { 
^bb0(%0 : i64):
  %1 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %2 = "riscv.slt"(%1, %1) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %3 = "builtin.unrealized_conversion_cast"(%2) : (!riscv.reg) -> (i1)
  %4 = "builtin.unrealized_conversion_cast"(%3) : (i1) -> (!riscv.reg)
  %5 = "riscv.andi"(%4){immediate = 1 : i12 } : (!riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i64)
  "llvm.return"(%6) : (i64) -> ()
 }
