{
^bb0(%arg0: i5):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i5) -> i13
  "llvm.return"(%0) : (i13) -> ()
}
