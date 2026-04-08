{
^bb0(%arg0: i25):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i25) -> i53
  "llvm.return"(%0) : (i53) -> ()
}
