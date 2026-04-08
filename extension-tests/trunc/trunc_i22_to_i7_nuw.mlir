{
^bb0(%arg0: i22):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i22) -> i7
  "llvm.return"(%0) : (i7) -> ()
}
