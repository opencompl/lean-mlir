{
^bb0(%arg0: i35):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i35) -> i49
  "llvm.return"(%0) : (i49) -> ()
}
