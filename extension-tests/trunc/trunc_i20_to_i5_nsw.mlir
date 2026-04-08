{
^bb0(%arg0: i20):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i20) -> i5
  "llvm.return"(%0) : (i5) -> ()
}
