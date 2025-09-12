; run ./process.sh arithLLVM.ll
; or 
; run ./preprocess.sh arithLLVM.ll and run lake manually
define i64 @xor(i64 %a, i64 %b) {
entry:
  %0 = xor i64 %a, %b ; various flags such as nuw, nsw are possible 
  ret i64 %0
}

 define i64 @main(i64 %arg0, i64 %arg1)  {
  %out = call i64 @xor(i64 %arg0, i64 %arg1)
  ret i64 %out
}

