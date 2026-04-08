{
^bb0(%arg0: i48):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i48) -> i19
  "llvm.return"(%0) : (i19) -> ()
}
