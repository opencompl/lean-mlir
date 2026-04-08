{
^bb0(%arg0: i46):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i46) -> i20
  "llvm.return"(%0) : (i20) -> ()
}
