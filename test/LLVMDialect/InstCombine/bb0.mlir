{
  ^bb0(%arg0: i64):
    %0 = "llvm.mlir.constant"() {value = 8 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 31 : i64} : () -> i64
    %2 = "llvm.ashr"(%arg0, %1) : (i64, i64) -> i64
    %3 = "llvm.and"(%2, %0) : (i64, i64) -> i64
    %4 = "llvm.add"(%3, %2) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
}

builtin.module { 
^bb0(%0 : i64):
  %1 = "riscv.li"() {immediate = 8 : i20 } : () -> (!riscv.reg)
  %2 = "riscv.li"() {immediate = 31 : i20 } : () -> (!riscv.reg)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %4 = "riscv.sra"(%3, %2) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %5 = "riscv.and"(%4, %1) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "riscv.add"(%5, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %7 = "builtin.unrealized_conversion_cast"(%6) : (!riscv.reg) -> (i64)
  "llvm.return"(%7) : (i64) -> ()
 }