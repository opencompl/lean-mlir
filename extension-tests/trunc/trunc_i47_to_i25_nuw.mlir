{
^bb0(%arg0: i47):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i47) -> i25
  "llvm.return"(%0) : (i25) -> ()
}
