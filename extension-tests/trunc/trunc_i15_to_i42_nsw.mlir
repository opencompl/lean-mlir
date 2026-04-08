{
^bb0(%arg0: i15):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i15) -> i42
  "llvm.return"(%0) : (i42) -> ()
}
