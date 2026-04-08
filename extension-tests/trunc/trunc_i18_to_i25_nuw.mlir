{
^bb0(%arg0: i18):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i18) -> i25
  "llvm.return"(%0) : (i25) -> ()
}
