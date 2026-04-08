{
^bb0(%arg0: i36):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i36) -> i16
  "llvm.return"(%0) : (i16) -> ()
}
