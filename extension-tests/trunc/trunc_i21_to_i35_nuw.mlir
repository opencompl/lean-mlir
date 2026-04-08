{
^bb0(%arg0: i21):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i21) -> i35
  "llvm.return"(%0) : (i35) -> ()
}
