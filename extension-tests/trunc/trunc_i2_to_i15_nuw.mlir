{
^bb0(%arg0: i2):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i2) -> i15
  "llvm.return"(%0) : (i15) -> ()
}
