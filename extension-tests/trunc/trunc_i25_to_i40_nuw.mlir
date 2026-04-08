{
^bb0(%arg0: i25):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i25) -> i40
  "llvm.return"(%0) : (i40) -> ()
}
