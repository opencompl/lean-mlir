{
^bb0(%arg0: i25):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i25) -> i18
  "llvm.return"(%0) : (i18) -> ()
}
