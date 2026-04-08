{
^bb0(%arg0: i39):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i39) -> i15
  "llvm.return"(%0) : (i15) -> ()
}
