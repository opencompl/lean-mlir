{
^bb0(%arg0: i45):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i45) -> i57
  "llvm.return"(%0) : (i57) -> ()
}
