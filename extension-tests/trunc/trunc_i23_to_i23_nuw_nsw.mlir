{
^bb0(%arg0: i23):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i23) -> i23
  "llvm.return"(%0) : (i23) -> ()
}
