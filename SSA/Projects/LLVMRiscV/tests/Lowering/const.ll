; constants have to be tested using an pther operation since they are not part of llvm but mlir's
; llvm dialects

define i64 @add_const(i64 %a) {
entry:
  %0 = add i64 -1, 0; various flags such as nuw, nsw are possible 
  ret i64 %0
}

 define i64 @main(i64 %arg0, i64 %arg1)  {
  %out = call i64 @add_const(i64 %arg0)
  ret i64 %out
}