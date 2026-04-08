{
^bb0(%arg0: i7):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i7) -> i53
  "llvm.return"(%0) : (i53) -> ()
}
