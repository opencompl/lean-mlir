{
^bb0(%arg0: i15):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i15) -> i3
  "llvm.return"(%0) : (i3) -> ()
}
