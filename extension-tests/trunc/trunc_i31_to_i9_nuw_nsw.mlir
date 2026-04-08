{
^bb0(%arg0: i31):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i31) -> i9
  "llvm.return"(%0) : (i9) -> ()
}
