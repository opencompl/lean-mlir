{
^bb0(%arg0: i14):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i14) -> i26
  "llvm.return"(%0) : (i26) -> ()
}
