builtin.module { 
^bb0(%0 : i1):
  %1 = "builtin.unrealized_conversion_cast"(%0) : (i1) -> (!riscv.reg)
  %2 = "riscv.slli"(%1){shamt = -1 : i6 } : (!riscv.reg) -> (!riscv.reg)
  %3 = "riscv.srai"(%2){shamt = -1 : i6 } : (!riscv.reg) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%3) : (!riscv.reg) -> (i64)
  "llvm.return"(%4) : (i64) -> ()
 }
