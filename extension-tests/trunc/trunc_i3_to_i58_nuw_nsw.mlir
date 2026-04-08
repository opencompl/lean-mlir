{
^bb0(%arg0: i3):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i3) -> i58
  "llvm.return"(%0) : (i58) -> ()
}
