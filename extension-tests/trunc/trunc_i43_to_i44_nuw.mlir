{
^bb0(%arg0: i43):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i43) -> i44
  "llvm.return"(%0) : (i44) -> ()
}
