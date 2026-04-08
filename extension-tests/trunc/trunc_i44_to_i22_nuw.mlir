{
^bb0(%arg0: i44):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i44) -> i22
  "llvm.return"(%0) : (i22) -> ()
}
