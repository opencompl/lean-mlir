builtin.module { 
^bb0(%0 : i64, %1 : i64):
  %2 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %3 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %4 = "riscv.xor"(%2, %3) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %5 = "riscv.seqz"(%4) : (!riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i1)
  %7 = "builtin.unrealized_conversion_cast"(%6) : (i1) -> (!riscv.reg)
  %8 = "riscv.slli"(%7){shamt = -1 : i6 } : (!riscv.reg) -> (!riscv.reg)
  %9 = "riscv.srai"(%8){shamt = -1 : i6 } : (!riscv.reg) -> (!riscv.reg)
  %10 = "builtin.unrealized_conversion_cast"(%9) : (!riscv.reg) -> (i64)
  "llvm.return"(%10) : (i64) -> ()
 }
