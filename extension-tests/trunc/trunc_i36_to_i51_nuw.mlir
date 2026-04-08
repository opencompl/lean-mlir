{
^bb0(%arg0: i36):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i36) -> i51
  "llvm.return"(%0) : (i51) -> ()
}
