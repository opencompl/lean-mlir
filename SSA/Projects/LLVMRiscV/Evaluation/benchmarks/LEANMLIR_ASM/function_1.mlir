builtin.module { 
^bb0(%0 : i64, %1 : i64, %2 : i64):
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %5 = "riscv.xor"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "riscv.srl"(%5, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %7 = "riscv.sll"(%5, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %8 = "riscv.rem"(%6, %7) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %9 = "riscv.xor"(%3, %3) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %10 = "riscv.divu"(%6, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %11 = "riscv.srl"(%10, %7) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %12 = "builtin.unrealized_conversion_cast"(%2) : (i64) -> (!riscv.reg)
  %13 = "riscv.mul"(%12, %11) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %14 = "riscv.div"(%9, %13) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %15 = "riscv.sltu"(%14, %8) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %16 = "riscv.xori"(%15){immediate = 1 : si12 } : (!riscv.reg) -> (!riscv.reg)
  %17 = "builtin.unrealized_conversion_cast"(%16) : (!riscv.reg) -> (i1)
  "llvm.return"(%17) : (i1) -> ()
 }
