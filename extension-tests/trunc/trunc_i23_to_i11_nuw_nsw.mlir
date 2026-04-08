{
^bb0(%arg0: i23):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i23) -> i11
  "llvm.return"(%0) : (i11) -> ()
}
