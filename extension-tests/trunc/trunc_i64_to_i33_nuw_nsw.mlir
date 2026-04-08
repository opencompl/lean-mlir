{
^bb0(%arg0: i64):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i64) -> i33
  "llvm.return"(%0) : (i33) -> ()
}
