{
^bb0(%arg0: i18):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i18) -> i44
  "llvm.return"(%0) : (i44) -> ()
}
