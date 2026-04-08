{
^bb0(%arg0: i54):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i54) -> i40
  "llvm.return"(%0) : (i40) -> ()
}
