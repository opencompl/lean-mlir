{
^bb0(%arg0: i51):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i51) -> i4
  "llvm.return"(%0) : (i4) -> ()
}
