{
^bb0(%arg0: i5):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i5) -> i38
  "llvm.return"(%0) : (i38) -> ()
}
