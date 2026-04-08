{
^bb0(%arg0: i26):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i26) -> i43
  "llvm.return"(%0) : (i43) -> ()
}
