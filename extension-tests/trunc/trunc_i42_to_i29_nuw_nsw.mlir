{
^bb0(%arg0: i42):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i42) -> i29
  "llvm.return"(%0) : (i29) -> ()
}
