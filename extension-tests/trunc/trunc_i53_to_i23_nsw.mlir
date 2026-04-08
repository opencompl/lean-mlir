{
^bb0(%arg0: i53):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i53) -> i23
  "llvm.return"(%0) : (i23) -> ()
}
