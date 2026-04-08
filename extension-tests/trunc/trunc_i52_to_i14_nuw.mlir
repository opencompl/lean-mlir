{
^bb0(%arg0: i52):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i52) -> i14
  "llvm.return"(%0) : (i14) -> ()
}
