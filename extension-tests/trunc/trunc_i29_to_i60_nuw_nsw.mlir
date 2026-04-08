{
^bb0(%arg0: i29):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i29) -> i60
  "llvm.return"(%0) : (i60) -> ()
}
