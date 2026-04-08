{
^bb0(%arg0: i29):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i29) -> i17
  "llvm.return"(%0) : (i17) -> ()
}
