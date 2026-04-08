{
^bb0(%arg0: i17):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i17) -> i58
  "llvm.return"(%0) : (i58) -> ()
}
