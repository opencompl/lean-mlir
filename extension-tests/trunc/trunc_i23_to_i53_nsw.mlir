{
^bb0(%arg0: i23):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i23) -> i53
  "llvm.return"(%0) : (i53) -> ()
}
