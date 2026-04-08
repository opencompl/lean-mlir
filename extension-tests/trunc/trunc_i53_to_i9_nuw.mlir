{
^bb0(%arg0: i53):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i53) -> i9
  "llvm.return"(%0) : (i9) -> ()
}
