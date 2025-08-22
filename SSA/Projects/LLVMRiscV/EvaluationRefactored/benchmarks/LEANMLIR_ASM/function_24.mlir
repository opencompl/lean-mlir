builtin.module { 
^bb0(%0 : i64):
  %1 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %2 = "riscv.div"(%1, %1) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %3 = "riscv.or"(%2, %1) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%3) : (!riscv.reg) -> (i64)
  "llvm.return"(%4) : (i64) -> ()
 }
