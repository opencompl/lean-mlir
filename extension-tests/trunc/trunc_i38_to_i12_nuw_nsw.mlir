{
^bb0(%arg0: i38):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i38) -> i12
  "llvm.return"(%0) : (i12) -> ()
}
