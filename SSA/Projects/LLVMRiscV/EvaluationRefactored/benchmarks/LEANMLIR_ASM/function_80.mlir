builtin.module { 
^bb0(%0 : i64):
  %1 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %2 = "riscv.xor"(%1, %1) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %3 = "riscv.seqz"(%2) : (!riscv.reg) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%3) : (!riscv.reg) -> (i1)
  "llvm.return"(%4) : (i1) -> ()
 }
