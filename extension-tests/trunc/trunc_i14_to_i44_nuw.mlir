{
^bb0(%arg0: i14):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i14) -> i44
  "llvm.return"(%0) : (i44) -> ()
}
