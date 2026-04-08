{
^bb0(%arg0: i58):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i58) -> i62
  "llvm.return"(%0) : (i62) -> ()
}
