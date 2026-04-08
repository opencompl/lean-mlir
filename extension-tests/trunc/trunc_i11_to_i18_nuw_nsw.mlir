{
^bb0(%arg0: i11):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i11) -> i18
  "llvm.return"(%0) : (i18) -> ()
}
