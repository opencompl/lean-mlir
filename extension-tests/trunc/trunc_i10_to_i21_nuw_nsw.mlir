{
^bb0(%arg0: i10):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i10) -> i21
  "llvm.return"(%0) : (i21) -> ()
}
