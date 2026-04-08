{
^bb0(%arg0: i55):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i55) -> i29
  "llvm.return"(%0) : (i29) -> ()
}
