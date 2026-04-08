{
^bb0(%arg0: i9):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i9) -> i22
  "llvm.return"(%0) : (i22) -> ()
}
