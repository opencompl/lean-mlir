define i64 @rem(i64 %a, i64 %b) {
entry:
  %0 = srem i64 %a, %b ; various flags such as nuw, nsw are possible 
  ret i64 %0
}

 define i64 @main(i64 %arg0, i64 %arg1)  {
  %out = call i64 @rem(i64 %arg0, i64 %arg1)
  ret i64 %out
}
;builtin.module { 
;^bb0(%0 : i64, %1 : i64):
  ;%2 = "riscv.builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  ;%3 = "riscv.builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  ;%4 = "riscv.rem"(%2, %3) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  ;%5 = "riscv.builtin.unrealized_conversion_cast"(%4) : (!riscv.reg) -> (i64)
  ;"riscv.ret"(%5) : (i64) -> ()
 ;}