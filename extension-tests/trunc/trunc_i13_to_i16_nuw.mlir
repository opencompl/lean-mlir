{
^bb0(%arg0: i13):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i13) -> i16
  "llvm.return"(%0) : (i16) -> ()
}
