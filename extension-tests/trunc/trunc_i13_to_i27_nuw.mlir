{
^bb0(%arg0: i13):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i13) -> i27
  "llvm.return"(%0) : (i27) -> ()
}
