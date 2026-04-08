{
^bb0(%arg0: i45):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i45) -> i53
  "llvm.return"(%0) : (i53) -> ()
}
