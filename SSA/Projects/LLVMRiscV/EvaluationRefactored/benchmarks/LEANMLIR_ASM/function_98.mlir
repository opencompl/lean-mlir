builtin.module { 
^bb0(%0 : i1):
  %1 = "builtin.unrealized_conversion_cast"(%0) : (i1) -> (!riscv.reg)
  %2 = "riscv.andi"(%1){immediate = 1 : i12 } : (!riscv.reg) -> (!riscv.reg)
  %3 = "riscv.slt"(%2, %2) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %4 = "riscv.xori"(%3){immediate = 1 : si12 } : (!riscv.reg) -> (!riscv.reg)
  %5 = "builtin.unrealized_conversion_cast"(%4) : (!riscv.reg) -> (i1)
  "llvm.return"(%5) : (i1) -> ()
 }
