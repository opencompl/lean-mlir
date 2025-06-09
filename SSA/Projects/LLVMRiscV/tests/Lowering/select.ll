define i64 @add(i1 %cond, i64 %a, i64 %b) {
entry:
  %0 = select i64 %cond, %a, %b ; various flags such as nuw, nsw are possible 
  ret i64 %0
}

 define i64 @main(i1 %cond, i64 %arg0, i64 %arg1)  {
  %out = call i64 @add(i64 %arg0, i64 %arg1)
  ret i64 %out
}
;builtin.module { 
^bb0(%0 : i64, %1 : i64, %2 : i1):
  %3 = "riscv.builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %4 = "riscv.builtin.unrealized_conversion_cast"(%2) : (i64) -> (!riscv.reg)
  %5 = "riscv.builtin.unrealized_conversion_cast"(%0) : (i1) -> (!riscv.reg)
  %6 = "riscv.slli"(%5){shamt = -1 : i6 } : !riscv.reg } : (!riscv.reg) -> (!riscv.reg)
  %7 = "riscv.srai"(%6){shamt = -1 : i6 } : !riscv.reg } : (!riscv.reg) -> (!riscv.reg)
  %8 = "riscv.and"(%3, %7) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %9 = "riscv.li"() {immediate = -1 : i20 } : () -> (!riscv.reg)
  %10 = "riscv.xor"(%9, %7) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %11 = "riscv.and"(%10, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %12 = "riscv.or"(%8, %11) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %13 = "riscv.builtin.unrealized_conversion_cast"(%12) : (!riscv.reg) -> (i64)
  "riscv.ret"(%13) : (i64) -> ()
 }