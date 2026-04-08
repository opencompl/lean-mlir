{
^bb0(%arg0: i36):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i36) -> i4
  "llvm.return"(%0) : (i4) -> ()
}
