{
^bb0(%arg0: i7):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i7) -> i58
  "llvm.return"(%0) : (i58) -> ()
}
