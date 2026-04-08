{
^bb0(%arg0: i39):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i39) -> i14
  "llvm.return"(%0) : (i14) -> ()
}
