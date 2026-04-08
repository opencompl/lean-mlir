{
^bb0(%arg0: i61):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i61) -> i62
  "llvm.return"(%0) : (i62) -> ()
}
