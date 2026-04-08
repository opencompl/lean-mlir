{
^bb0(%arg0: i54):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i54) -> i48
  "llvm.return"(%0) : (i48) -> ()
}
