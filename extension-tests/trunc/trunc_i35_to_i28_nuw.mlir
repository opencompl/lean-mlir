{
^bb0(%arg0: i35):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i35) -> i28
  "llvm.return"(%0) : (i28) -> ()
}
