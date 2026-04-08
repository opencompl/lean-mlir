{
^bb0(%arg0: i49):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i49) -> i49
  "llvm.return"(%0) : (i49) -> ()
}
