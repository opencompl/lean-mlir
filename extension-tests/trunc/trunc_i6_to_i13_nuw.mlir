{
^bb0(%arg0: i6):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i6) -> i13
  "llvm.return"(%0) : (i13) -> ()
}
