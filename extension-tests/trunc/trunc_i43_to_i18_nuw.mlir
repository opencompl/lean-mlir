{
^bb0(%arg0: i43):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i43) -> i18
  "llvm.return"(%0) : (i18) -> ()
}
