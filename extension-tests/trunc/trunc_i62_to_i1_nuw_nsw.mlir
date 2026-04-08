{
^bb0(%arg0: i62):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i62) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
