{
^bb0(%arg0: i35):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i35) -> i3
  "llvm.return"(%0) : (i3) -> ()
}
