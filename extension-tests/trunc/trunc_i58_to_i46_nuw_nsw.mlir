{
^bb0(%arg0: i58):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i58) -> i46
  "llvm.return"(%0) : (i46) -> ()
}
