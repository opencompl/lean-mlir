{
^bb0(%arg0: i49):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i49) -> i6
  "llvm.return"(%0) : (i6) -> ()
}
