{
^bb0(%arg0: i61):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i61) -> i58
  "llvm.return"(%0) : (i58) -> ()
}
