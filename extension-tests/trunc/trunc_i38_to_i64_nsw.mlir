{
^bb0(%arg0: i38):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i38) -> i64
  "llvm.return"(%0) : (i64) -> ()
}
