{
^bb0(%arg0: i4):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i4) -> i8
  "llvm.return"(%0) : (i8) -> ()
}
