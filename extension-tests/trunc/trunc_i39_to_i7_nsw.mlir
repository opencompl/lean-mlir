{
^bb0(%arg0: i39):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i39) -> i7
  "llvm.return"(%0) : (i7) -> ()
}
