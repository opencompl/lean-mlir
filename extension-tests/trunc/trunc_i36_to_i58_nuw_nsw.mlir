{
^bb0(%arg0: i36):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i36) -> i58
  "llvm.return"(%0) : (i58) -> ()
}
