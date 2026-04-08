{
^bb0(%arg0: i25):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i25) -> i52
  "llvm.return"(%0) : (i52) -> ()
}
