{
^bb0(%arg0: i62):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i62) -> i16
  "llvm.return"(%0) : (i16) -> ()
}
