{
^bb0(%arg0: i58):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i58) -> i63
  "llvm.return"(%0) : (i63) -> ()
}
