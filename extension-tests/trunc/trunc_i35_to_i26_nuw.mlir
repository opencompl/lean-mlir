{
^bb0(%arg0: i35):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i35) -> i26
  "llvm.return"(%0) : (i26) -> ()
}
