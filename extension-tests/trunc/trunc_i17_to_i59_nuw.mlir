{
^bb0(%arg0: i17):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i17) -> i59
  "llvm.return"(%0) : (i59) -> ()
}
