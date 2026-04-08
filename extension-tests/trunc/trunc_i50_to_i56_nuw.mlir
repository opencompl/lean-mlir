{
^bb0(%arg0: i50):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i50) -> i56
  "llvm.return"(%0) : (i56) -> ()
}
