{
^bb0(%arg0: i7):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i7) -> i27
  "llvm.return"(%0) : (i27) -> ()
}
