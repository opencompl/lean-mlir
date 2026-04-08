{
^bb0(%arg0: i29):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i29) -> i15
  "llvm.return"(%0) : (i15) -> ()
}
