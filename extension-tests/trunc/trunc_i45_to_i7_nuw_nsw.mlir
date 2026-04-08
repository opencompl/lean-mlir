{
^bb0(%arg0: i45):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i45) -> i7
  "llvm.return"(%0) : (i7) -> ()
}
