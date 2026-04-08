{
^bb0(%arg0: i52):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i52) -> i35
  "llvm.return"(%0) : (i35) -> ()
}
