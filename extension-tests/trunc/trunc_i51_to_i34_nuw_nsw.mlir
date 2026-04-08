{
^bb0(%arg0: i51):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i51) -> i34
  "llvm.return"(%0) : (i34) -> ()
}
