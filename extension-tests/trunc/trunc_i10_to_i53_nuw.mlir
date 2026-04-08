{
^bb0(%arg0: i10):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i10) -> i53
  "llvm.return"(%0) : (i53) -> ()
}
