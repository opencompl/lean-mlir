{
^bb0(%arg0: i27):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i27) -> i42
  "llvm.return"(%0) : (i42) -> ()
}
