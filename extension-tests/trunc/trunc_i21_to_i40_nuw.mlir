{
^bb0(%arg0: i21):
  %0 = "llvm.trunc"(%arg0) overflow<nuw> : (i21) -> i40
  "llvm.return"(%0) : (i40) -> ()
}
