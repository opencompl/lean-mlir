{
^bb0(%arg0: i28):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i28) -> i39
  "llvm.return"(%0) : (i39) -> ()
}
