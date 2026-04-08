{
^bb0(%arg0: i30):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i30) -> i8
  "llvm.return"(%0) : (i8) -> ()
}
