{
^bb0(%arg0: i27):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i27) -> i16
  "llvm.return"(%0) : (i16) -> ()
}
