{
^bb0(%arg0: i53):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i53) -> i17
  "llvm.return"(%0) : (i17) -> ()
}
