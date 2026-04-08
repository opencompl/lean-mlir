{
^bb0(%arg0: i19):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i19) -> i49
  "llvm.return"(%0) : (i49) -> ()
}
