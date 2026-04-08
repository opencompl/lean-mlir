{
^bb0(%arg0: i60):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i60) -> i34
  "llvm.return"(%0) : (i34) -> ()
}
