builtin.module { 
^bb0(%0 : i64, %1 : i64, %2 : i64, %3 : i1):
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %5 = "riscv.sra"(%4, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %7 = "riscv.rem"(%6, %5) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %8 = "builtin.unrealized_conversion_cast"(%2) : (i64) -> (!riscv.reg)
  %9 = "riscv.sra"(%8, %8) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %10 = "riscv.sub"(%9, %9) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %11 = "riscv.srl"(%7, %10) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %12 = "riscv.add"(%11, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %13 = "riscv.and"(%11, %12) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %14 = "builtin.unrealized_conversion_cast"(%3) : (i1) -> (!riscv.reg)
  %15 = "riscv.andi"(%14){immediate = 1 : i12 } : (!riscv.reg) -> (!riscv.reg)
  %16 = "riscv.sub"(%13, %15) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %17 = "riscv.sltu"(%12, %16) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %18 = "builtin.unrealized_conversion_cast"(%17) : (!riscv.reg) -> (i1)
  "llvm.return"(%18) : (i1) -> ()
 }
