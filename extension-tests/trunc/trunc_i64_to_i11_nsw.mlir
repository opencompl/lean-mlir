{
^bb0(%arg0: i64):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i64) -> i11
  "llvm.return"(%0) : (i11) -> ()
}
