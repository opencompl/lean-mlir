{
^bb0(%arg0: i47):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i47) -> i3
  "llvm.return"(%0) : (i3) -> ()
}
