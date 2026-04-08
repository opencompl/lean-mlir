{
^bb0(%arg0: i49):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i49) -> i35
  "llvm.return"(%0) : (i35) -> ()
}
