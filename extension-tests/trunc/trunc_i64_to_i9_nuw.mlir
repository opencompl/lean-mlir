{
^bb0(%arg0: i64):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i64) -> i9
  "llvm.return"(%0) : (i9) -> ()
}
