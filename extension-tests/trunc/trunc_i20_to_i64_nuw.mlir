{
^bb0(%arg0: i20):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i20) -> i64
  "llvm.return"(%0) : (i64) -> ()
}
