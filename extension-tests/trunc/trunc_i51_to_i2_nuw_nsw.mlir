{
^bb0(%arg0: i51):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i51) -> i2
  "llvm.return"(%0) : (i2) -> ()
}
