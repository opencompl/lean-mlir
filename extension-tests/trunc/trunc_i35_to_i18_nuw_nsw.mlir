{
^bb0(%arg0: i35):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i35) -> i18
  "llvm.return"(%0) : (i18) -> ()
}
