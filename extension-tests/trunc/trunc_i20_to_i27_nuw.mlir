{
^bb0(%arg0: i20):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i20) -> i27
  "llvm.return"(%0) : (i27) -> ()
}
