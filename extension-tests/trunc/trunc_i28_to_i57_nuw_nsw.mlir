{
^bb0(%arg0: i28):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i28) -> i57
  "llvm.return"(%0) : (i57) -> ()
}
