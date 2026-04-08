{
^bb0(%arg0: i16):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i16) -> i49
  "llvm.return"(%0) : (i49) -> ()
}
