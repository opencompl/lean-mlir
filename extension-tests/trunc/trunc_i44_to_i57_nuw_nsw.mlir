{
^bb0(%arg0: i44):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i44) -> i57
  "llvm.return"(%0) : (i57) -> ()
}
