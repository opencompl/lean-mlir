{
^bb0(%arg0: i40):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i40) -> i42
  "llvm.return"(%0) : (i42) -> ()
}
