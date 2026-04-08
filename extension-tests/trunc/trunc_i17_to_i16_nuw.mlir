{
^bb0(%arg0: i17):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i17) -> i16
  "llvm.return"(%0) : (i16) -> ()
}
