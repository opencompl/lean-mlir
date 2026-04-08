{
^bb0(%arg0: i29):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i29) -> i22
  "llvm.return"(%0) : (i22) -> ()
}
