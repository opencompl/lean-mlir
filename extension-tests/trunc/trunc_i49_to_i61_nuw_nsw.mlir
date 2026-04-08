{
^bb0(%arg0: i49):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i49) -> i61
  "llvm.return"(%0) : (i61) -> ()
}
