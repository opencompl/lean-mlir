{
^bb0(%arg0: i34):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i34) -> i57
  "llvm.return"(%0) : (i57) -> ()
}
