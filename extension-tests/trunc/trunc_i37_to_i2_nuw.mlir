{
^bb0(%arg0: i37):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i37) -> i2
  "llvm.return"(%0) : (i2) -> ()
}
