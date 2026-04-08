{
^bb0(%arg0: i42):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i42) -> i5
  "llvm.return"(%0) : (i5) -> ()
}
