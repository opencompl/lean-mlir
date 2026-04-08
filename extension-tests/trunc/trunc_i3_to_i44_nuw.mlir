{
^bb0(%arg0: i3):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i3) -> i44
  "llvm.return"(%0) : (i44) -> ()
}
