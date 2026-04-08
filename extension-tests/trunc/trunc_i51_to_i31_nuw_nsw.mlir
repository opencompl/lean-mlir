{
^bb0(%arg0: i51):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i51) -> i31
  "llvm.return"(%0) : (i31) -> ()
}
