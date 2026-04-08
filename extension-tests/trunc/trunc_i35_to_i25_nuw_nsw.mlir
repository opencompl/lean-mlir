{
^bb0(%arg0: i35):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i35) -> i25
  "llvm.return"(%0) : (i25) -> ()
}
