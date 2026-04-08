{
^bb0(%arg0: i42):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i42) -> i30
  "llvm.return"(%0) : (i30) -> ()
}
