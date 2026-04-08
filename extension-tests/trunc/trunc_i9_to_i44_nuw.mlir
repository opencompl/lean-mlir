{
^bb0(%arg0: i9):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i9) -> i44
  "llvm.return"(%0) : (i44) -> ()
}
