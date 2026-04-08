{
^bb0(%arg0: i30):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i30) -> i27
  "llvm.return"(%0) : (i27) -> ()
}
