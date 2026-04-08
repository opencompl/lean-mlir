{
^bb0(%arg0: i36):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i36) -> i54
  "llvm.return"(%0) : (i54) -> ()
}
