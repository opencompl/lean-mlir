{
^bb0(%arg0: i11):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i11) -> i2
  "llvm.return"(%0) : (i2) -> ()
}
