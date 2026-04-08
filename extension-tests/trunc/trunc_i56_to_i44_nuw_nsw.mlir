{
^bb0(%arg0: i56):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i56) -> i44
  "llvm.return"(%0) : (i44) -> ()
}
