{
^bb0(%arg0: i38):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i38) -> i39
  "llvm.return"(%0) : (i39) -> ()
}
