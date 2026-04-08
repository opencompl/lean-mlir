{
^bb0(%arg0: i34):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i34) -> i25
  "llvm.return"(%0) : (i25) -> ()
}
