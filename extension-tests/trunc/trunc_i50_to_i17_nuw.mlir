{
^bb0(%arg0: i50):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i50) -> i17
  "llvm.return"(%0) : (i17) -> ()
}
