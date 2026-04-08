{
^bb0(%arg0: i35):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i35) -> i59
  "llvm.return"(%0) : (i59) -> ()
}
