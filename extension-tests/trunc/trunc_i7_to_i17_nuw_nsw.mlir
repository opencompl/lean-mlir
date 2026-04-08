{
^bb0(%arg0: i7):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i7) -> i17
  "llvm.return"(%0) : (i17) -> ()
}
