{
^bb0(%arg0: i2):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i2) -> i54
  "llvm.return"(%0) : (i54) -> ()
}
