{
^bb0(%arg0: i24):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i24) -> i45
  "llvm.return"(%0) : (i45) -> ()
}
