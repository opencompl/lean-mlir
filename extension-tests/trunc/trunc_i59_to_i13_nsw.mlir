{
^bb0(%arg0: i59):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i59) -> i13
  "llvm.return"(%0) : (i13) -> ()
}
