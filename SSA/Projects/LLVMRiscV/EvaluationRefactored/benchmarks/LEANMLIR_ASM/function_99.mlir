builtin.module { 
^bb0(%0 : i1):
  %1 = "builtin.unrealized_conversion_cast"(%0) : (i1) -> (!riscv.reg)
  %2 = "riscv.andi"(%1){immediate = 1 : i12 } : (!riscv.reg) -> (!riscv.reg)
  %3 = "riscv.div"(%2, %2) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%3) : (!riscv.reg) -> (i64)
  "llvm.return"(%4) : (i64) -> ()
 }
