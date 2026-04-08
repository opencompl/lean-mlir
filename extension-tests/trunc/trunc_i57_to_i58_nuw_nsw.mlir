{
^bb0(%arg0: i57):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i57) -> i58
  "llvm.return"(%0) : (i58) -> ()
}
