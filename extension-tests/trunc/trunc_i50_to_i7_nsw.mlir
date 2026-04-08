{
^bb0(%arg0: i50):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i50) -> i7
  "llvm.return"(%0) : (i7) -> ()
}
