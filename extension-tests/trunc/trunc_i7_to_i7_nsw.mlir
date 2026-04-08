{
^bb0(%arg0: i7):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i7) -> i7
  "llvm.return"(%0) : (i7) -> ()
}
