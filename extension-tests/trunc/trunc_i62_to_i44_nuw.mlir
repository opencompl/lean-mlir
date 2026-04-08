{
^bb0(%arg0: i62):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i62) -> i44
  "llvm.return"(%0) : (i44) -> ()
}
