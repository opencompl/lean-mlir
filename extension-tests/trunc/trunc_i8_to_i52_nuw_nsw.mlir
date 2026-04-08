{
^bb0(%arg0: i8):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i8) -> i52
  "llvm.return"(%0) : (i52) -> ()
}
