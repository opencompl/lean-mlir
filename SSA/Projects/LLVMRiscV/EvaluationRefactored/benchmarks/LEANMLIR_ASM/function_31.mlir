builtin.module { 
^bb0(%0 : i1):
  %1 = "builtin.unrealized_conversion_cast"(%0) : (i1) -> (!riscv.reg)
  %2 = "riscv.andi"(%1){immediate = 1 : i12 } : (!riscv.reg) -> (!riscv.reg)
  %3 = "builtin.unrealized_conversion_cast"(%2) : (!riscv.reg) -> (i64)
  %4 = "llvm.srem"(%3, %3) : (i64, i64) -> (i64)
  "llvm.return"(%4) : (i64) -> ()
 }
