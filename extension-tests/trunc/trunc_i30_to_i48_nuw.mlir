{
^bb0(%arg0: i30):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i30) -> i48
  "llvm.return"(%0) : (i48) -> ()
}
