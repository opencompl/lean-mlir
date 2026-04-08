{
^bb0(%arg0: i5):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i5) -> i44
  "llvm.return"(%0) : (i44) -> ()
}
