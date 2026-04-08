{
^bb0(%arg0: i8):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i8) -> i50
  "llvm.return"(%0) : (i50) -> ()
}
