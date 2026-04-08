{
^bb0(%arg0: i8):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i8) -> i7
  "llvm.return"(%0) : (i7) -> ()
}
