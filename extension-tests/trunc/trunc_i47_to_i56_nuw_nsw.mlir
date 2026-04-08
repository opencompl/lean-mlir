{
^bb0(%arg0: i47):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i47) -> i56
  "llvm.return"(%0) : (i56) -> ()
}
