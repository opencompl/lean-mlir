{
^bb0(%arg0: i17):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i17) -> i13
  "llvm.return"(%0) : (i13) -> ()
}
