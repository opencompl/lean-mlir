{
^bb0(%arg0: i51):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i51) -> i50
  "llvm.return"(%0) : (i50) -> ()
}
