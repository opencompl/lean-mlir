{
^bb0(%arg0: i53):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i53) -> i5
  "llvm.return"(%0) : (i5) -> ()
}
