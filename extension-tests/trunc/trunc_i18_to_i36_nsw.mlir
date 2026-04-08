{
^bb0(%arg0: i18):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i18) -> i36
  "llvm.return"(%0) : (i36) -> ()
}
