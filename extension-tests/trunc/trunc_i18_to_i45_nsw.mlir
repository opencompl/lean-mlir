{
^bb0(%arg0: i18):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i18) -> i45
  "llvm.return"(%0) : (i45) -> ()
}
