{
^bb0(%arg0: i13):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i13) -> i63
  "llvm.return"(%0) : (i63) -> ()
}
