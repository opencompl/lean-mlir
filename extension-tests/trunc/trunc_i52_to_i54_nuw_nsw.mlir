{
^bb0(%arg0: i52):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i52) -> i54
  "llvm.return"(%0) : (i54) -> ()
}
