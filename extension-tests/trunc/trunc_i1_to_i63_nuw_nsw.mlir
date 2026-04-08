{
^bb0(%arg0: i1):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i1) -> i63
  "llvm.return"(%0) : (i63) -> ()
}
