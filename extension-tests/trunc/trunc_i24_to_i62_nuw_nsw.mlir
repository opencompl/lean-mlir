{
^bb0(%arg0: i24):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i24) -> i62
  "llvm.return"(%0) : (i62) -> ()
}
