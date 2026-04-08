{
^bb0(%arg0: i58):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i58) -> i58
  "llvm.return"(%0) : (i58) -> ()
}
