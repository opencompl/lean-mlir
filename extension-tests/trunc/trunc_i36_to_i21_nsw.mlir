{
^bb0(%arg0: i36):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i36) -> i21
  "llvm.return"(%0) : (i21) -> ()
}
