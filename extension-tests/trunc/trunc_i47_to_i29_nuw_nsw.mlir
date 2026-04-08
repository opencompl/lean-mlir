{
^bb0(%arg0: i47):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i47) -> i29
  "llvm.return"(%0) : (i29) -> ()
}
