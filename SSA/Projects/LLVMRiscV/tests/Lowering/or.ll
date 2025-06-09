define i64 @or(i64 %a, i64 %b) {
entry:
  %0 = or i64 %a, %b ; flag is exact is also supported
  ret i64 %0
}

 define i64 @main(i64 %arg0, i64 %arg1)  {
  %out = call i64 @or(i64 %arg0, i64 %arg1)
  ret i64 %out
}

; for no exact flag and exact flag
;builtin.module { 
^bb0(%0 : i64, %1 : i64):
  %2 = "riscv.builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %3 = "riscv.builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %4 = "riscv.or"(%2, %3) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %5 = "riscv.builtin.unrealized_conversion_cast"(%4) : (!riscv.reg) -> (i64)
  "riscv.ret"(%5) : (i64) -> ()
 ;}