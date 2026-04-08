{
^bb0(%arg0: i12):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i12) -> i34
  "llvm.return"(%0) : (i34) -> ()
}
