{
^bb0(%arg0: i11):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i11) -> i64
  "llvm.return"(%0) : (i64) -> ()
}
