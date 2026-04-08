{
^bb0(%arg0: i53):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i53) -> i12
  "llvm.return"(%0) : (i12) -> ()
}
