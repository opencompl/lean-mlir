{
^bb0(%arg0: i4):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i4) -> i35
  "llvm.return"(%0) : (i35) -> ()
}
