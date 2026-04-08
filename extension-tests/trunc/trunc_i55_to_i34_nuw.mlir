{
^bb0(%arg0: i55):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i55) -> i34
  "llvm.return"(%0) : (i34) -> ()
}
