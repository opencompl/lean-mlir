{
^bb0(%arg0: i34):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i34) -> i17
  "llvm.return"(%0) : (i17) -> ()
}
