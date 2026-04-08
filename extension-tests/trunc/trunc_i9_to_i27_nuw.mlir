{
^bb0(%arg0: i9):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i9) -> i27
  "llvm.return"(%0) : (i27) -> ()
}
