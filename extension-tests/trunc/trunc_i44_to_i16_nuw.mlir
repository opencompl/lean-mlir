{
^bb0(%arg0: i44):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i44) -> i16
  "llvm.return"(%0) : (i16) -> ()
}
