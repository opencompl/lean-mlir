{
^bb0(%arg0: i23):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i23) -> i4
  "llvm.return"(%0) : (i4) -> ()
}
