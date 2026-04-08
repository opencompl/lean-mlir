{
^bb0(%arg0: i18):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i18) -> i57
  "llvm.return"(%0) : (i57) -> ()
}
