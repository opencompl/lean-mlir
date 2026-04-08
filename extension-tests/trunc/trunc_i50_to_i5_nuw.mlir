{
^bb0(%arg0: i50):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i50) -> i5
  "llvm.return"(%0) : (i5) -> ()
}
