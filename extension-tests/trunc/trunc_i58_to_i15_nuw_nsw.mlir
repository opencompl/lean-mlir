{
^bb0(%arg0: i58):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i58) -> i15
  "llvm.return"(%0) : (i15) -> ()
}
