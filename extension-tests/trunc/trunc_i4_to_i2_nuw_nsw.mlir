{
^bb0(%arg0: i4):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i4) -> i2
  "llvm.return"(%0) : (i2) -> ()
}
