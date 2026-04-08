{
^bb0(%arg0: i43):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i43) -> i12
  "llvm.return"(%0) : (i12) -> ()
}
