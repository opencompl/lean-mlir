{
^bb0(%arg0: i46):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i46) -> i36
  "llvm.return"(%0) : (i36) -> ()
}
