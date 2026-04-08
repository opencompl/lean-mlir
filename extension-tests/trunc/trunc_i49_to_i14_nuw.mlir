{
^bb0(%arg0: i49):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i49) -> i14
  "llvm.return"(%0) : (i14) -> ()
}
