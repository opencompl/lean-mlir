{
^bb0(%arg0: i9):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i9) -> i7
  "llvm.return"(%0) : (i7) -> ()
}
