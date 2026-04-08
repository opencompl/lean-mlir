{
^bb0(%arg0: i39):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i39) -> i50
  "llvm.return"(%0) : (i50) -> ()
}
