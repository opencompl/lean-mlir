{
^bb0(%arg0: i7):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i7) -> i20
  "llvm.return"(%0) : (i20) -> ()
}
