{
^bb0(%arg0: i1):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i1) -> i47
  "llvm.return"(%0) : (i47) -> ()
}
