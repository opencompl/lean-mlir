{
^bb0(%arg0: i59):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i59) -> i57
  "llvm.return"(%0) : (i57) -> ()
}
