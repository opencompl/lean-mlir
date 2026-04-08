{
^bb0(%arg0: i15):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i15) -> i30
  "llvm.return"(%0) : (i30) -> ()
}
