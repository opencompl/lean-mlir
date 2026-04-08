{
^bb0(%arg0: i6):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i6) -> i63
  "llvm.return"(%0) : (i63) -> ()
}
