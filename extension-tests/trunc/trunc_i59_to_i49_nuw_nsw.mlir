{
^bb0(%arg0: i59):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i59) -> i49
  "llvm.return"(%0) : (i49) -> ()
}
