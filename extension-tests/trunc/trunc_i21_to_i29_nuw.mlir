{
^bb0(%arg0: i21):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i21) -> i29
  "llvm.return"(%0) : (i29) -> ()
}
