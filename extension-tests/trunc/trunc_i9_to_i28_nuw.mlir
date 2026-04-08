{
^bb0(%arg0: i9):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i9) -> i28
  "llvm.return"(%0) : (i28) -> ()
}
