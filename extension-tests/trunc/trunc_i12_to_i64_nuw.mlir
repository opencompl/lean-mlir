{
^bb0(%arg0: i12):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i12) -> i64
  "llvm.return"(%0) : (i64) -> ()
}
