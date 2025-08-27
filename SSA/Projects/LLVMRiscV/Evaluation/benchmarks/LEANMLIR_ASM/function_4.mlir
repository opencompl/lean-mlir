builtin.module { 
^bb0(%0 : i64, %1 : i64, %2 : i64):
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %4 = "riscv.add"(%3, %3) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %5 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %6 = "riscv.and"(%4, %5) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %7 = "riscv.mul"(%6, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %8 = "builtin.unrealized_conversion_cast"(%2) : (i64) -> (!riscv.reg)
  %9 = "riscv.sub"(%8, %5) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %10 = "riscv.sub"(%7, %9) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %11 = "riscv.sll"(%10, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %12 = "riscv.and"(%11, %6) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %13 = "riscv.rem"(%4, %12) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %14 = "riscv.slt"(%10, %13) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %15 = "riscv.xori"(%14){immediate = 1 : si12 } : (!riscv.reg) -> (!riscv.reg)
  %16 = "builtin.unrealized_conversion_cast"(%15) : (!riscv.reg) -> (i1)
  %17 = "llvm."InstCombine.MOp.UnaryOp.trunc (ConcreteOrMVar.concrete 64) { nsw := false, nuw := false }""(%16) : (i1) -> (i64)
  "llvm.return"(%17) : (i64) -> ()
 }
