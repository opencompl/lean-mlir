{
^bb0(%arg0: i20):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i20) -> i41
  "llvm.return"(%0) : (i41) -> ()
}
