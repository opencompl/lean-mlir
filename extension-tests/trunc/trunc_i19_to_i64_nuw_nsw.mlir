{
^bb0(%arg0: i19):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i19) -> i64
  "llvm.return"(%0) : (i64) -> ()
}
