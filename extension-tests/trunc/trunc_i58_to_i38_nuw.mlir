{
^bb0(%arg0: i58):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i58) -> i38
  "llvm.return"(%0) : (i38) -> ()
}
