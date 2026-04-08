{
^bb0(%arg0: i1):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i1) -> i49
  "llvm.return"(%0) : (i49) -> ()
}
