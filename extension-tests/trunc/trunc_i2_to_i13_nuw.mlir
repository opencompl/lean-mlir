{
^bb0(%arg0: i2):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i2) -> i13
  "llvm.return"(%0) : (i13) -> ()
}
