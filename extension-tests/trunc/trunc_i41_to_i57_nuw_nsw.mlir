{
^bb0(%arg0: i41):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i41) -> i57
  "llvm.return"(%0) : (i57) -> ()
}
