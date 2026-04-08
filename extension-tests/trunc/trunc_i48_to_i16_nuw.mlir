{
^bb0(%arg0: i48):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i48) -> i16
  "llvm.return"(%0) : (i16) -> ()
}
