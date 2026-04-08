{
^bb0(%arg0: i39):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i39) -> i58
  "llvm.return"(%0) : (i58) -> ()
}
