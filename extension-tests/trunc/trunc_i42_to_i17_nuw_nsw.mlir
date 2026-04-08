{
^bb0(%arg0: i42):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i42) -> i17
  "llvm.return"(%0) : (i17) -> ()
}
