{
^bb0(%arg0: i12):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i12) -> i6
  "llvm.return"(%0) : (i6) -> ()
}
