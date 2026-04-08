{
^bb0(%arg0: i4):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i4) -> i15
  "llvm.return"(%0) : (i15) -> ()
}
