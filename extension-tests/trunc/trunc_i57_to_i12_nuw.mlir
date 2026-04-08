{
^bb0(%arg0: i57):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i57) -> i12
  "llvm.return"(%0) : (i12) -> ()
}
