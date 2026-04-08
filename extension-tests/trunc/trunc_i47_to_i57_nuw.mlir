{
^bb0(%arg0: i47):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i47) -> i57
  "llvm.return"(%0) : (i57) -> ()
}
