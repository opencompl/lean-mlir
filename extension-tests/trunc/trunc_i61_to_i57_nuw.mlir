{
^bb0(%arg0: i61):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i61) -> i57
  "llvm.return"(%0) : (i57) -> ()
}
