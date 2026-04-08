{
^bb0(%arg0: i40):
  %0 = "llvm.trunc"(%arg0) overflow<nuw, nsw> : (i40) -> i50
  "llvm.return"(%0) : (i50) -> ()
}
