{
^bb0(%arg0: i14):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i14) -> i4
  "llvm.return"(%0) : (i4) -> ()
}
