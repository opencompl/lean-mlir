{
^bb0(%arg0: i18):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i18) -> i42
  "llvm.return"(%0) : (i42) -> ()
}
