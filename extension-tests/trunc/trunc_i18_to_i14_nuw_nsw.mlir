{
^bb0(%arg0: i18):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i18) -> i14
  "llvm.return"(%0) : (i14) -> ()
}
