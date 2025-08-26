; run ./process.sh arithLLVM.ll
; or 
; run ./preprocess.sh arithLLVM.ll and run lake manually

define i64 @add(i64 %a, i64 %b) {
entry:
  %0 = add i64 %a, %b
  ret i64 %0
}

 define i64 @main(i64 %arg0, i64 %arg1)  {
  %out = call i64 @add(i64 %arg0, i64 %arg1)
  ret i64 %out
}