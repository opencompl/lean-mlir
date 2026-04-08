{
^bb0(%arg0: i36):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i36) -> i17
  "llvm.return"(%0) : (i17) -> ()
}
