{
^bb0(%arg0: i30):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i30) -> i19
  "llvm.return"(%0) : (i19) -> ()
}
