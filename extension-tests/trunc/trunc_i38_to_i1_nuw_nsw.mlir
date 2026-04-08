{
^bb0(%arg0: i38):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i38) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
